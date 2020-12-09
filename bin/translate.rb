#!/usr/bin/env ruby
# https://cloud.google.com/translate/docs/quickstart-client-libraries
begin
  require 'google/cloud/translate'
rescue LoadError
  puts 'Please install ruby google cloud translate gem and set env variable'
  puts 'export GOOGLE_APPLICATION_CREDENTIALS=....'
  puts 'gem install google-cloud-translate'
  exit
end
project_id = 'cybernetic-tide-90121'
translate = Google::Cloud::Translate.translation_v2_service project_id: project_id

target = ARGV[0] || 'ru'
text = STDIN.gets

translation = translate.translate text, to: target
print translation
