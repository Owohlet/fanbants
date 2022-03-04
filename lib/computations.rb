class Computations
	
	def initialize
		@file_lines = []
	end
	def handle_input(command_array, write_output)

		case command_array.shift.downcase
		when "add"

			# new cards start with a balance of 0
			command_array.push("$0")

			# check for validation
			pass_validation = luhn_10(command_array[1])

			if pass_validation == false
				command_array.push("error" + "\n")
			else
				command_array.push("success" + "\n")
			end

			# Add new customer to file
			@file_lines.push(command_array.join(" "))

			# sort the data
			@file_lines = @file_lines.sort

			# write to output
			if write_output == true
				output = write_to_output(@file_lines)
				return output
			end

		when "charge"
			# fetch the record
			record = fetch_record(command_array)
			customer_record = record[0]
			line_index = record[1]
			# puts "*************"
			# puts "#{command_array}"
			# puts "#{customer_record}"
			# puts "----------"
			# puts "#{@file_lines}"
			customer_record = customer_record.split(" ")

			# check if the card number passes luhn_10
			if customer_record[4] == "success"
				# Increase the balance by the amount specified
				new_balance = customer_record[3].tr('$', '').to_i + command_array.last.tr('$', '').to_i

				# check if the new balance > limit # if so, ignore
				if new_balance > customer_record[2].tr('$', '').to_i
					# puts "This operation exceeds customer #{customer_record.first}'s limit. Ignoring request"
					return
				end

				new_line = "#{customer_record[0]} #{customer_record[1]} #{customer_record[2]} #{'$' + new_balance.to_s} #{customer_record[4]}\n"

				@file_lines[line_index] = new_line
			end

			# send_to_output
			if write_output == true
				output = write_to_output(@file_lines)
				return output
			end

		when "credit"

			# fetch the record
			record = fetch_record(command_array)
			customer_record = record[0]
			line_index = record[1]
			customer_record = customer_record.split(" ")

			# check if the card number passes luhn_10
			if customer_record[4] == "success"	
				# decrease the balance by the amount specified
				new_balance = customer_record[3].tr('$', '').to_i - command_array.last.tr('$', '').to_i

				# write to file
				new_line = "#{customer_record[0]} #{customer_record[1]} #{customer_record[2]} #{'$' + new_balance.to_s} #{customer_record[4]}\n"

				@file_lines[line_index] = new_line
			end

			if write_output == true
				# send to output
				output = write_to_output(@file_lines)
				return output
			end

		else
			puts "invalid syntax"
		end
	end

	def fetch_record(command_array)
		customer = ""

		@file_lines.each_with_index do |line, indx| 
			if line.to_s.downcase.include?(command_array.first.downcase)
				customer = [line, indx]
			end
		end

		# puts "#{customer}"
		if customer == ""
			puts "customer #{command_array.first} is not added... Add customer first"
			exit!
		else
			return customer
		end
	end

	def write_to_output(sorted_file_lines)

		output = []
		sorted_file_lines.each do |line|
			customer = line.split(" ")
			if customer[4] == "error" 
				output << "#{customer[0]} #{customer[4]}"
			else
				output << "#{customer[0]} #{customer[3]}"
			end
		end

		return output

	end

	def luhn_10(numbers)
		numbers = numbers.chars
		odds_total = 0
		evens_total = 0
		for i in 0...numbers.length
			digit = numbers[numbers.length - 1 - i]
			if i.odd?
				new_num = digit.to_i * 2
				if new_num > 9
					ref_new_num = 1 + new_num.to_s.chars.last.to_i
					odds_total += ref_new_num
				else
					odds_total += new_num
				end
			else
				evens_total += digit.to_i
			end
		end

		total = evens_total + odds_total
		if total % 10 == 0
			return true
		else
			return false
		end

	end
end


