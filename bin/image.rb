#!/usr/bin/env ruby
begin
  require 'rmagick'
rescue LoadError
  puts 'Please install rmagick gem'
  puts 'gem install rmagick'
  exit
end
require 'byebug'

print_help if ARGV[0] == '-h' || ARGV.empty?

method_name = ARGV[0]
case method_name
when 'resize_if_gt'
  max_width = ARGV[1].to_i
  puts 'max_width should be greater than 0' and exit if max_width.zero?
  puts "resize_if_gt for max_width= #{max_width}"
  ARGV[2..-1].each do |file_name|
    resize_if_gt(max_width, file_name)
  end
when 'watermark'
  text = ARGV[1]
  puts "text=#{text} should be present" and exit if text.size.zero?
  puts "watermark for text=#{text}"
  ARGV[2..-1].each do |file_name|
    watermark(text, file_name)
  end
else
  puts "unknown method_name=#{method_name}"
  print_help
  exit
end

# rubocop:disable Metrics/MethodLength
BEGIN {
  def resize_if_gt(max_width, file_name)
    # puts "processing #{file_name}"
    i = Magick::Image.ping(file_name).first
    if i.columns <= max_width
      puts "Ignoring #{file_name} since width is #{i.columns}"
      return
    end

    i = _load_and_save_original file_name
    puts "Processing #{file_name} #{i.columns}x#{i.rows}"
    i = i.change_geometry(max_width.to_s) { |cols, rows, img| img.resize!(cols, rows) }
    puts "now is #{i.columns}x#{i.rows}"
    i.write file_name
  end

  def watermark(text, file_name)
    i = _load_and_save_original file_name
    dir_name = File.dirname(file_name)
    modified_untracked = `git ls-files -o -m #{dir_name}`
    staged = `git diff --cached --name-only #{dir_name}`
    unless (modified_untracked + staged).include? file_name
      puts "Ignoring #{file_name} since it is not changed"
      return
    end

    draw = Magick::Draw.new
    draw.font_family = 'Ubuntu-Bold'
    draw.font_weight = 900
    draw.pointsize = 33
    draw.gravity = Magick::SouthGravity
    draw.annotate i, 0, 0, 1, 1, text do
      self.fill = 'gray43'
    end
    draw.annotate i, 0, 0, 1, -1, text do
      self.fill = 'gray43'
    end
    draw.annotate i, 0, 0, -1, -1, text do
      self.fill = 'gray43'
    end
    draw.annotate i, 0, 0, -1, 1, text do
      self.fill = 'gray43'
    end
    draw.annotate i, 0, 0, 0, 0, text do
      self.fill = 'white'
    end
    puts "Adding watermark to #{file_name}"
    i.write file_name
  end

  def _load_and_save_original(file_name)
    i = Magick::Image.read(file_name).first
    dir_name = File.dirname(file_name) + '/original/'
    Dir.mkdir dir_name unless File.exist? dir_name
    original_file_name = dir_name + File.basename(file_name)
    i.write original_file_name unless File.exist?(original_file_name)
    i
  end

  def print_help
    puts <<~TEXT
      image.rb works with images, resize, watermark
      For examle:

          image.rb resize_if_gt 680 assets/posts/*.jpg
          image.rb watermark iznamljivanje-sup-daske-novi-sad.trk.in.rs assets/posts/*.jpg
    TEXT
  end
}
# rubocop:enable Metrics/MethodLength
