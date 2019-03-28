#!/usr/bin/env ruby
# rubocop:disable Style/GlobalVars
# https://cloud.google.com/translate/docs/quickstart-client-libraries
begin
  require 'google/cloud/translate'
rescue LoadError
  puts <<~TEXT
    Please install ruby google cloud translate gem
        gem install google-cloud-translate'
    and set env variables
        export GOOGLE_PROJECT_ID=cybernetic-tide-90121
        export GOOGLE_APPLICATION_CREDENTIALS=....'
  TEXT
  exit
end

require 'byebug'

project_id = ENV['GOOGLE_PROJECT_ID']
$google_clound_translate = Google::Cloud::Translate.new project: project_id

if ARGV[0] == '-h' || ARGV.length < 2
  puts <<-TEXT
    yml_google_translate_api.rb config/locales/**/*.yml sr hi
    # It will load one or more files, translate to provided languages only if
    # translation does not exists already for that language and key
  TEXT
  exit
end

file_path = ARGV.shift
to_langs = ARGV
PLACEHOLDER_REPEAT = 2

def escape(string)
  res = string
  keys = string.scan /\%\{(.*?)\}/
  keys = keys.flatten
  keys.each_with_index do |key, index|
    res = res.sub "%{#{key}}", index.to_s * PLACEHOLDER_REPEAT
  end
  [keys, res]
end

def unescape(translated, keys)
  res = translated
  keys.each_with_index do |key, index|
    res = res.sub index.to_s * PLACEHOLDER_REPEAT, "%{#{key}}"
  end
  res
end

def translate_string(string, from_lang, to_lang)
  return '' if string.empty?

  escaped_keys, escaped_string = escape(string)
  translated = $google_clound_translate.translate(escaped_string, from: from_lang, to: to_lang).to_s
  result = unescape translated, escaped_keys
  puts "#{string}-> #{escaped_string} => #{translated} -> #{result}"
  result
end

def translate_array(array, existing, from_lang, to_lang)
  res = []
  array.each_with_index do |v, i|
    res.append existing[i] || translate_string(v, from_lang, to_lang)
  end
  res
end

def translate_hash(hash, existing, from_lang, to_lang)
  res = {}
  hash.each do |(k, v)|
    res[k] = case v
             when String
               existing[k] || translate_string(v, from_lang, to_lang)
             when Hash
               translate_hash(v, existing[k], from_lang, to_lang)
             when Array
               translate_array(v, existing[k], from_lang, to_lang)
             else
               # v.is_a?(Integer) or v.is_a?(FalseClass) or v.is_a?(TrueClass)
               v
             end
  end
  res
end

# https://stackoverflow.com/a/17251424/287166
class Hash
  def insert_before(key, kvpair)
    arr = to_a
    pos = arr.index(arr.assoc(key))
    if pos
      arr.insert(pos, kvpair)
    else
      arr << kvpair
    end
    replace Hash[arr]
  end
end

Dir.glob(file_path).each do |file_name|
  from_hash = YAML.load_file file_name
  from_lang = from_hash.keys.first
  to_langs.each do |to_lang|
    puts "*** converting #{file_name} to #{to_lang}"
    to_file = file_name.sub("#{from_lang}.yml", "#{to_lang}.yml")
    to_hash = if File.exist?(to_file)
                YAML.load_file to_file
              else
                { to_lang: nil }
              end

    to_hash = { to_lang => translate_hash(from_hash[from_lang], to_hash[to_lang], from_lang, to_lang) }
    File.write to_file, to_hash.to_yaml
  end
end
# it could be that Google raises
# /home/orlovic/.rvm/gems/ruby-2.5.3/gems/google-cloud-translate-1.2.4/lib/google/cloud/translate/service.rb:129:in
# `rescue in execute': Google::Cloud::ResourceExhaustedError
# (Google::Cloud::ResourceExhaustedError)
# but just repeat the command

# rubocop:enable Style/GlobalVars
