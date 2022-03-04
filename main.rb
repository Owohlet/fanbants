#!/usr/bin/ruby
require './lib/staging.rb'

if ARGV.first
	input_file = ARGV.first
	file_lines = File.readlines(input_file)
else
	input = $stdin.read
	file_lines = input.split("\n")
end
output = start(file_lines)
STDOUT.puts output
