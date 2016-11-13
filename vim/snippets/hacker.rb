PRODUCTION = false
if PRODUCTION
  def ppp(_arg = nil); end

  def pp(_arg = nil); end
else
  require 'pp'
  require './ppp'
  require 'byebug'
end

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def solution(a)
  r = a.length
  ppp "r=#{r}"
  r
end

if PRODUCTION
  n = gets.to_i
  a = []
  n.times do
    # strip is needed since on hackerrank, new line is at the end of gets
    r = gets.strip.split('').map { |c| c == '*' ? 0 : 1 }
    a << r
  end
  puts solution(a)
end # if PRODUCTION
