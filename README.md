# Welcome to Computations!

This is the computations program. To get started install the rspec gem.

`gem install rspec`

The program runs from the main.rb file accompanied by an input.txt file.

`ruby main.rb input.txt`

There is a second `input2.txt` if you want to test with a larger but similar data

`Add Tom 4111111111111111 $1000`
`Charge Tom $800`

if you're adding inputs from STDIN be sure to hit `enter` and `ctrl D` when you're done


# That Pesky input.txt
Edge cases were not all handled in this program so the input.txt file needs to follow specific format. 

The `First_name` must have the first letter in capital followed by other small letters e.g. `Madara`, `Naruto`, `Eren`. This is so the sorting algorithm sort consistently


# Testing

This program includes 2 test files. To run the unit test run 

`rspec spec/computations_spec.rb` to run the computation specs and 

`rspec spec/staging_spec.rb` to run the staging specs or just run `rspec` to run all tests


# Architecture

The program is separated into units that handle different required parts of program for example

`luhn_10` method specifically tests if new and existing cards meet this requirement.
`fetch_record` method fetches the specific customer record from the file.


The program tries to avoid needless O(n) situations, therefore, computations like the luhn_10 and sorting are saved when the program is run the first time, so that computations perform faster after each run

