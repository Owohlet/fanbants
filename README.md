# Welcome to Computations!

This is the computations program. To get started install the colorize gem.

`gem install colorize`

The program runs from the main.rb file accompanied by an input.txt file.

`ruby main.rb input.txt`

There is a second `input2.txt` if you want to test with a separate but similar data

You will see a message asking what you want to do. The general commands include "Add", "Charge" and "Credit". For e.g

`Add Tom 4111111111111111 $1000`
`Charge Tom $800`
`Credit Lisa $100`

# Quiting
To quit the program run 
`exit`


# That Pesky input.txt
Edge cases were not all handled in this program so the input.txt file needs to follow specific format. 
`[First_name] [credit_card_number] [limit]`

The `First_name` must have the first letter in capital followed by other small letters e.g. `Madara`, `Naruto`, `Eren`. This is so the sorting algorithm sort consistently

The last record must also have only one *new line* (\n). This is so the file writes can be consistent.



# Testing

This program includes 3 unit tests which is a basic comparison of results from the methods and the expected results. To run the unit test run 

`ruby computations_test.rb`


# Architecture

The program is separated into units that handle different required parts of program for example

`luhn_10` method specifically tests if new and existing cards meet this requirement.
`fetch_record` method fetches the specific customer record from the file.
`check_for_validation` method determines if it's necessary to check if the record requires a luhn_10 validation.
`insertion_sort` method performs an insertion sorting algorithm to use if we encounter nearly sorted data

The program tries to avoid needless O(n) situations, therefore, computations like the luhn_10 and sorting are saved when the program is run the first time, so that computations perform faster after each run

# Sorting
Because the result requires sorting on each command, it is necessary to sort the file in the beginning. For this ruby's default sorting which uses quicksort is used because the initial file is unknown.

Beyond this sorting is really only required for **adding new records** and the data is nearly sorted therefore we use *insertion sort* algorithm because it best for nearly sorted data

# Output.txt
One last thing, the program writes output to output.txt. This doesn't affect anything and you don't have to even interact with it. It was just in my head that maybe you would want to know the current state of things in the current output format without running a command specifically.

