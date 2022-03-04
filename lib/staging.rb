require './lib/computations.rb'

def start(file_lines)
	output = []
	write_output = false
	compute = Computations.new

	file_lines.each do |line|
		if line == file_lines.last
			write_output = true
		end
		output = compute.handle_input(line.split(" "), write_output)
	end

	return output
end