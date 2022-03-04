require 'spec_helper'
require_relative '../lib/staging'

describe 'staging' do

	let(:valid_file_input) {File.readlines('spec/fixtures/test_input.txt')}
	let(:invalid_file_input) {File.readlines('spec/fixtures/invalid_test_input.txt')}

	context "given a valid file input" do
		it "should return a valid output" do
			expect(start(valid_file_input)).to eq(["Lisa $-93","Quincy error","Tom $500"])
		end
	end

	# context "given a invalid file input. Does not 'add' but 'credits'" do
	# 	it "should return a string asking to add first" do
	# 		expect(start(invalid_file_input)).to output("customer Quincy is not added... Add customer first").to_stdout
	# 	end
	# end
end