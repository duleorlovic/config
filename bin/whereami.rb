#!/usr/bin/env ruby
#
# TODO: find blocks inside same intent and remove in level
# FULL_PREVIOUS_IF_NOT_BEGIN_WITH_SAME_WORD
#
# Run test:
#   whereami.rb test
# Specific test
#   whereami.rb --name test_same_level_on_previous
# Use byebug
#   ruby -rbyebug whereami.rb test --name test_only_previous
# or uncomment following line
# require 'byebug'

LEVELS = [
  ONLY_PREVIOUS = 'only_previous'.freeze,
  SAME_LEVEL_ON_PREVIOUS = 'same_level_on_previous'.freeze,
  FULL_PREVIOUS_IF_NOT_BEGIN_WITH_SAME_WORD = 'full_previous_if_not_begin_with_same_word'.freeze,
].freeze

def read_from_file(filename, target_line)
  result = []
  unless File.exist? filename
    puts "File #{filename} does not exists!"
    exit
  end
  current_line = 1
  File.foreach filename do |line|
    result << line.rstrip
    break if current_line >= target_line

    current_line += 1
  end
  result
end

# when we jump back (indent < last_indent) than we clear all higher indents
# ONLY_PREVIOUS skip all same levels
# SAME_LEVEL_ON_PREVIOUS will keep same level but only on previous (last line
# level is skipped)
# FULL_PREVIOUS_IF_NOT_BEGIN_WITH_SAME_WORD
#
def pop_lines_greater_than_indent(lines, line_indents, indent, level, last_line)
  line_indents.reverse.each do |i|
    if i == indent && level == SAME_LEVEL_ON_PREVIOUS && last_line
      lines.pop
      line_indents.pop
    elsif i == indent && level == ONLY_PREVIOUS
      lines.pop
      line_indents.pop
    elsif i > indent && level != FULL_PREVIOUS_IF_NOT_BEGIN_WITH_SAME_WORD
      lines.pop
      line_indents.pop
    else
      # i < indent : we already cleaned that
      break
    end
  end
end

def clear_lines(text_array, level, filename = 'test')
  lines = []
  line_indents = []
  last_indent = 0
  text_array.each_with_index do |line, index|
    next if line.size.zero?

    last_line = index + 1 == text_array.size
    indent = line.match(/^\s*/)[0].size
    pop_lines_greater_than_indent(lines, line_indents, indent, level, last_line) if indent <= last_indent

    line_indents << indent
    lines << format_output(line, index, filename)
    last_indent = indent
  end
  lines
end

def format_output(line, index, filename)
  "#{filename}:#{index + 1}-#{line}"
end

if ARGV[0] != 'test'
  filename = ARGV[0]
  target_line = ARGV[1].to_i
  level = ARGV[2] || ONLY_PREVIOUS

  EXAMPLE_USAGE = <<~HERE_DOC.freeze
    Arguments: whereami.rb {filename} {line_number} {level}
    filename is for example a.txt
    line_number is 1
    level options are: #{LEVELS.join(' and ')}. Default is #{ONLY_PREVIOUS}.
    For example:
      whereami.rb my_file.txt 1
      whereami.rb my_file.txt 1 #{SAME_LEVEL_ON_PREVIOUS}

    Run tests:
      whereami.rb test
  HERE_DOC

  if filename.to_s.empty?
    puts 'Please provide filename'
    puts EXAMPLE_USAGE
    exit
  end
  if target_line.zero?
    puts 'Please provide the target_line number'
    puts EXAMPLE_USAGE
    exit
  end
  unless LEVELS.include? level
    puts 'Please use correct level'
    puts EXAMPLE_USAGE
    exit
  end
  result = clear_lines(read_from_file(filename, target_line), level, filename).join("\n") + "\n"
  puts result
else
  require 'minitest/autorun'
  class Test < Minitest::Test
    def sample
      <<~TEXT
        # MyClass
        class MyClass
          CONST = 1

          def my_c_method
            c = 1
            d = 1
          end

          # My method
          def my_method
            a = 1
            b = 1
      TEXT
        .split("\n")
    end

    def test_only_previous
      result = <<~TEXT
        test:2-class MyClass
        test:11-  def my_method
        test:13-    b = 1
      TEXT
      assert_equal result, clear_lines(sample, ONLY_PREVIOUS).join("\n") + "\n"
    end

    def test_same_level_on_previous
      result = <<~TEXT
        test:1-# MyClass
        test:2-class MyClass
        test:3-  CONST = 1
        test:5-  def my_c_method
        test:8-  end
        test:10-  # My method
        test:11-  def my_method
        test:13-    b = 1
      TEXT
      actual = clear_lines(sample, SAME_LEVEL_ON_PREVIOUS).join("\n") + "\n"
      assert_equal result, actual
    end

    def test_full_previous_if_not_begin_with_same_word
      result = <<~TEXT
        test:1-# MyClass
        test:2-class MyClass
        test:3-  CONST = 1
        test:5-  def my_c_method
        test:6-    c = 1
        test:7-    d = 1
        test:8-  end
        test:10-  # My method
        test:11-  def my_method
        test:13-    b = 1
      TEXT
      actual = clear_lines(sample, FULL_PREVIOUS_IF_NOT_BEGIN_WITH_SAME_WORD).join("\n") + "\n"
      assert_equal result, actual
    end
  end
end
