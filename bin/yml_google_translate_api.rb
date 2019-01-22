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
    yml_google_translate_api.rb en sr
    # default is to convert all files in config/locales, but you can specify
    yml_google_translate_api.rb en sr config/locales/en.yml
  TEXT
  exit
end

$from_lang = ARGV[0]
$to_lang = ARGV[1]
file_path = ARGV[2] || 'config/locales'
PLACEHOLDER_REPEAT = 2

file_path += '/**/*.yml' unless file_path[-3..-1] == 'yml' || file_path.index('*')

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

# rubocop:disable Rails/Blank
def blank?(string)
  string.nil? || string.empty?
end
# rubocop:enable Rails/Blank

def translate_array(array)
  res = []
  array.each do |v|
    translated = if blank?(v)
                   ''
                 else
                   $google_clound_translate.translate(v, from: $from_lang, to: $to_lang).to_s
                 end
    res.append translated
  end
  res
end

# rubocop:disable Metrics/MethodLength
def translate_hash(hash)
  res = {}
  hash.each do |(k, v)|
    if v.is_a? String
      escaped_keys, escaped_string = escape(v)
      translated = $google_clound_translate.translate(escaped_string, from: $from_lang, to: $to_lang).to_s
      res[k] = unescape translated, escaped_keys
      puts "#{v}-> #{escaped_string} => #{translated} -> #{res[k]}"
    elsif v.is_a? Hash
      res[k] = translate_hash(v)
    elsif v.is_a? Array
      res[k] = translate_array(v)
    else
      # v.is_a?(Integer) or v.is_a?(FalseClass) or v.is_a?(TrueClass)
      res[k] = v
    end
  end
  res
end
# rubocop:enable Metrics/MethodLength

Dir.glob(file_path).each do |file_name|
  from_hash = YAML.load_file file_name
  to_file = file_name.sub(".#{$from_lang}.", ".#{$to_lang}.")
  next if blank?(from_hash[$from_lang])

  if File.exist?(to_file)
    puts "*** ignoring #{file_name} #{$from_lang} since #{to_file} already exists"
    next
  end
  puts "*** converting #{file_name} #{$from_lang}"

  to_hash = { $to_lang => translate_hash(from_hash[$from_lang]) }
  File.write to_file, to_hash.to_yaml
end
# it could be that Google raises
# /home/orlovic/.rvm/gems/ruby-2.5.3/gems/google-cloud-translate-1.2.4/lib/google/cloud/translate/service.rb:129:in
# `rescue in execute': Google::Cloud::ResourceExhaustedError
# (Google::Cloud::ResourceExhaustedError)
# but just repeat the command

# rubocop:enable Style/GlobalVars
