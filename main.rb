require './computations.rb'

input_file = ARGV.first
file_lines = File.readlines(input_file)
sorted_file_lines = file_lines.sort

puts "Welcome to computations... what do you want to do?"

command = STDIN.gets.chomp
while !(command == "exit") 
	command_array = command.split(" ")
	result = Computations.handle_input(command_array, input_file, sorted_file_lines)
	puts "\n"
	puts "You can run another command or quit. To quit run `exit`"

	command = STDIN.gets.chomp
end