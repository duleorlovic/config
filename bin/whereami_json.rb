#!/usr/bin/env ruby

# Show all path attribus so you can dig to it.
# For strings inside array you need to look at parent object path

# Run test
#   whereami_json.rb test
# Specific test
#   whereami_json.rb test --name test_same_level_on_previous
# Use byebug
#   ruby -rbyebug whereami_json.rb test --name test_only_previous
# or uncomment following line
# require 'byebug'

# puts JSON.pretty_generate(Const.add_keys(hash)).colorize "San Fr"

require "json"

class Const
  def self.add_keys(object, path_to_here = "")
    case object
    when Hash
      object.each_with_object({}) do |(k, v), a|
        new_path = "#{path_to_here} #{k}".strip 
        a[new_path] = add_keys(v, new_path)
      end
    when Array
      object.map.with_index do |o, i|
        new_path = "#{path_to_here} #{i}".strip 
        add_keys o, new_path
      end
    else
      object
    end
  end
end

if ARGV[0] != 'test'
  EXAMPLE_USAGE = <<~HERE_DOC.freeze
    Run tests:
      whereami_json.rb test
  HERE_DOC
  puts EXAMPLE_USAGE
else
  require 'minitest/autorun'
  class Test < Minitest::Test
    def test_simple_hash
      object = {"a" => 1,  "b" => {"c" => 2}}
      result = {"a" => 1, "b" => { "b c" => 2}}
      assert_equal result, Const.add_keys(object)
    end

    def test_simple_array
      object = { "a" => [ 1, { "b" => 2 }]}
      result = { "a" => [ 1, { "a 1 b" => 2 }]}
      assert_equal result, Const.add_keys(object)
    end

    def test_array
      object = [
        1,
        {
          "a" => [
            2,
            {
              "b" => "3",
              "c" => [
                4,
                {
                  "d" => 5,
                }
              ]
            }
          ]
        }
      ]
      result = [1, {"1 a" => [2, {"1 a 1 b" => "3", "1 a 1 c" => [ 4, { "1 a 1 c 1 d" => 5}]}]}]
      assert_equal result, Const.add_keys(object)
    end
  end
end
