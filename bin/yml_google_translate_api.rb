#!/usr/bin/env ruby
# rubocop:disable Style/GlobalVars
#
# gems:
#   activesupport - for humanize
#   cyrillizer - for cyr lating conversion
#   google-cloud-translate - for google api
#
# https://cloud.google.com/translate/docs/quickstart-client-libraries
require 'bundler/inline'
gemfile do
  gem 'google-cloud-translate' # 3.0.0
  gem 'cyrillizer'
  gem 'activesupport'
  gem 'debug'
end
require 'google/cloud/translate'
require 'cyrillizer'
require 'active_support'
require 'active_support/core_ext'
require 'debug'

project_id = ENV['GOOGLE_PROJECT_ID']
# $google_cloud_translate = Google::Cloud::Translate.translation_v2_service project_id: project_id
Cyrillizer.language = :serbian

if ARGV[0] == '-h' || ARGV.length < 2
  puts <<-TEXT
    yml_google_translate_api.rb config/locales/**/*.yml sr hi
    # It will load one or more files, translate to provided languages only if
    # translation does not exists already for that language and key
    # Use _to_lat _to_cyr _humanize to skip google api
    # Also check that you have env variables
    #        export GOOGLE_PROJECT_ID=cybernetic-tide-90121
    #        export GOOGLE_APPLICATION_CREDENTIALS=....'
    yml_google_translate_api.rb config/locales/sr.yml sr-latin_to_lat en_humanize
  TEXT
  exit
end

file_path = ARGV.shift
to_langs = ARGV
PLACEHOLDER_REPEAT = 2

def escape(string)
  res = string
  keys = string.to_s.scan /\%\{(.*?)\}/
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

def perform_translate(string, from_lang, to_lang, key)
  if to_lang.ends_with? '_to_lat'
    string.to_s.to_lat
  elsif to_lang.ends_with? '_to_cyr'
    string.to_s.to_cyr
  elsif to_lang.ends_with? '_humanize'
    key.humanize
  else
    begin
      from_lang = 'sr' if from_lang == 'sr-latin' # google does not use latin
      $google_cloud_translate.translate string, from: from_lang, to: to_lang
    rescue Google::Cloud::InvalidArgumentError => e
      # debugger
      raise e
    end
  end
end

def translate_string(string, from_lang, to_lang, key = nil)
  return nil if string.nil?
  return '' if string.empty?

  escaped_keys, escaped_string = escape(string)
  translated = perform_translate(escaped_string, from_lang, to_lang, key).to_s
  result = unescape translated, escaped_keys
  puts "#{string}-> #{escaped_string} => #{translated} -> #{result}"
  result
end

def translate_array(array, existing, from_lang, to_lang)
  res = []
  existing = [] if existing.nil?
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
               # if exists, we will remain with old value (note that it could be
               # diffent String or Hash)
               existing&.dig(k) || translate_string(v, from_lang, to_lang, k)
             when Hash
               translate_hash(v, existing&.dig(k), from_lang, to_lang)
             when Array
               translate_array(v, existing&.dig(k), from_lang, to_lang)
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

def skip_suffix(to_lang)
  to_lang.gsub /_to_cyr|_to_lat|_humanize/, ''
end

Dir.glob(file_path).each do |file_name|
  from_hash = YAML.load_file file_name
  from_lang = from_hash.keys.first
  to_langs.each do |to_lang|
    puts "*** converting #{file_name} to #{skip_suffix to_lang}"
    to_file = file_name.sub("#{from_lang}.yml", "#{skip_suffix to_lang}.yml")
    to_hash = if File.exist?(to_file)
                YAML.load_file to_file
              else
                { skip_suffix(to_lang) => nil }
              end

    to_hash = {
      skip_suffix(to_lang) => translate_hash(from_hash[from_lang], to_hash[skip_suffix(to_lang)], from_lang, to_lang)
    }
    File.write to_file, to_hash.to_yaml
  end
end
# it could be that Google raises
# /home/orlovic/.rvm/gems/ruby-2.5.3/gems/google-cloud-translate-1.2.4/lib/google/cloud/translate/service.rb:129:in
# `rescue in execute': Google::Cloud::ResourceExhaustedError
# (Google::Cloud::ResourceExhaustedError)
# but just repeat the command

# rubocop:enable Style/GlobalVars
