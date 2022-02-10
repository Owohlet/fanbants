require './computations.rb'
require 'colorize'
class ComputationsTest
	attr_accessor :success,:failure, :no_of_test

	def initialize
		@success = 0
		@failures = 0
		@no_of_test = 0	
	end

	def main
		# luhn_10 test
		luhn_10_test()

		# insertion sort test
		test_array = [1,2,5,6,11,13,17,19,23,40,99,8]
		result = [1,2,5,6,8,11,13,17,19,23,40,99]

		insertion_sort_test(test_array,result)

		# fetch record test
		file_lines = File.readlines('testinput.txt')
		command_array = ['Yelena','$100']
		result = ['Yelena 483731111837383748675 $2000 $0', 1]
		
		fetch_record_test(file_lines,command_array,result)
		
		# test outputs
		puts "#{('No of tests:' +' ' + @no_of_test.to_s).colorize(:color =>:cyan, :mode=> :bold)},    #{('Success:' +' ' + @success.to_s).colorize(:color =>:green, :mode=> :bold)},   #{('Failures:' +' ' + @failures.to_s).colorize(:color =>:red, :mode=> :bold)}"
	end

	def luhn_10_test(test_card="5399839204298532", result=true)
		# This tests for valid cards using Luhn 10
		test_result = Computations.luhn_10(test_card)
		@no_of_test += 1
		calculate(test_result, result)
	end

	def insertion_sort_test(test_array, result)
		# This tests for valid sorting
		test_result = Computations.insertion_sort(test_array)
		@no_of_test += 1
		calculate(test_result, result)
	end

	def fetch_record_test(file_lines, command_array, result)
		# To successfully fetch the correct result from a file
		test_result = Computations.fetch_record(file_lines,command_array)
		@no_of_test += 1
		calculate(test_result, result)
	end

	private
	def calculate(test_result, result)
		if test_result == result
			@success += 1
		else
			@failures += 1
		end
	end

end

new_tests = ComputationsTest.new
new_tests.main