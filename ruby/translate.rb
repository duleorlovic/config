#!/usr/bin/env ruby
# https://cloud.google.com/translate/docs/quickstart-client-libraries
begin
  require 'google/cloud/translate'
rescue LoadError
  puts 'Please install ruby google cloud translate gem'
  puts 'gem install google-cloud-translate'
  exit
end
# you need to export path to file export GOOGLE_APPLICATION_CREDENTIALS=....
project_id = 'cybernetic-tide-90121'
translate = Google::Cloud::Translate.new project: project_id

target = ARGV[0] || 'ru'
text = STDIN.gets

translation = translate.translate text, to: target
print translation
