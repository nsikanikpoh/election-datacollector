#!/usr/bin/env ruby

$: << '.'
$: << '../lib'
$: << '../ext'

require 'oj'


class MyParser
  def initialize
    @current_depth = 0
  end

  def parse(file)
    Oj.sc_parse(self, file)
  end

  def hash_start
    puts "start"
    @current_depth += 1
    raise Exception.new("Hello")
    {}
  end

  # Other Oj::ScHandler methods go below.
  # The parser's purpose is to find a specific value nested deep within the streaming JSON
  # and to stop parsing immediately afterward.
end

parser = MyParser.new
parser.parse(%|{"a":{"b":{"c":{}}}}|)
