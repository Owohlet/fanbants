class Computations
	def self.handle_input(command_array,input_file, file_lines)

		case command_array.shift.downcase
		when "add"

			# new cards start with a balance of 0
			command_array.push("$0")
			# check for validation
			pass_validation = luhn_10(command_array[1])

			if !(pass_validation == true)
				command_array.push("error" + "\n")
			else
				command_array[3] += "\n"
			end
			# Add new customer to file
			file_lines.push(command_array.join(" "))

			# sort the file using insertion sort
			sorted_file_lines = insertion_sort(file_lines)

			# write to output
			write_to_output(sorted_file_lines, input_file)


		when "charge"
			# fetch the record
			record = fetch_record(file_lines,command_array)

			customer_record = record[0]
			line_index = record[1]

			# Check for Luhn_10 #add fifth column for luhn_10 failure
			customer_record = check_for_validation(customer_record, input_file, file_lines, line_index)

			# Increase the balance by the amount specified
			new_balance = customer_record[3].tr('$', '').to_i + command_array.last.tr('$', '').to_i

			# check if the new balance > limit # if so, ignore
			if new_balance > customer_record[2].tr('$', '').to_i
				puts " #{customer_record} "
				puts "This operation exceeds customer limit. Ignoring request"
				return
			end

			new_line = "#{customer_record[0]} #{customer_record[1]} #{customer_record[2]} #{'$' + new_balance.to_s} #{customer_record[4]}\n"


			file_lines[line_index] = new_line

			# send_to_output
			write_to_output(file_lines, input_file)

			return

		when "credit"

			# fetch the record

			record = fetch_record(file_lines, command_array)
			customer_record = record[0]
			line_index = record[1]

			# check for luhn_10
			validated_customer = check_for_validation(customer_record, input_file, file_lines, line_index)

			# decrease the balance by the amount specified
			new_balance = validated_customer[3].tr('$', '').to_i - command_array.last.tr('$', '').to_i

			# write to file
			new_line = "#{validated_customer[0]} #{validated_customer[1]} #{validated_customer[2]} #{'$' + new_balance.to_s} #{validated_customer[4]}\n"

			file_lines[line_index] = new_line

			# send to output
			write_to_output(file_lines, input_file)
			return

		end
	end

	def self.fetch_record(file_lines, command_array)
		customer = ""

		file_lines.each_with_index do |line, indx| 
			if line.to_s.downcase.include?(command_array.first.downcase)
				customer = [line, indx]
			end
		end
		return customer
	end

	def self.check_for_validation(customer_record,input_file, file_lines, line_index)
		customer_record = customer_record.split(" ")
		if customer_record[4].nil? 
			# validation has not been run
			pass_validation = luhn_10(customer_record[1])
			if pass_validation == true
				customer_record[4] = "success"
				file_lines[line_index] = customer_record.join(" ") + "\n"

			else
				customer_record[4] = "error"
				# insert into input.txt
				file_lines[line_index] = customer_record.join(" ") + "\n"

				File.open(input_file, 'w') { |f| f.write(file_lines.join); f.close }

				puts "Customer card is invalid. Ignoring request"
				exit!
			end
		elsif customer_record[4] == "error"
			puts "Customer card is invalid. Ignoring request"
			exit!
		end
		return customer_record
	end

	def self.write_to_output(sorted_file_lines, input_file)
		File.open(input_file, 'w') do |f| 
			f.write(sorted_file_lines.join);
			f.close 
		end

		output = []
		sorted_file_lines.each do |line|
			customer = line.split(" ")
			if customer[4] == "error" 
				output << "#{customer[0]} #{customer[4]}\n"
			else
				output << "#{customer[0]} #{customer[3]}\n"
			end
		end

		output_file = File.open('output.txt', 'w') {|f| f.write(output.join); f.close}

		puts File.read("output.txt")
	end

	def self.insertion_sort(arr)
		for i in 1...arr.length
			current_val = arr[i]
			j = i - 1
			while j >= 0 && arr[j] > current_val
				arr[j+1] = arr[j]
				j -= 1
			end
			arr[j+1] = current_val
		end	

		return arr
	end

	def self.luhn_10(numbers)
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


