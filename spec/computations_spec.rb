require 'spec_helper'
require_relative '../lib/computations'


describe 'Computations' do
	let(:compute) { Computations.new }
	let(:write_output) {true}
	let(:line) {"Add Tom 4111111111111111 $1000"}
	let(:valid_card) {"4111111111111111"}
	let(:invalid_card) {"463838473823938473"}
	

	context "given a valid input" do
		it "should return a valid output" do
			expect(compute.handle_input(line.split(" "), write_output)).to eq(["Tom $0"])
		end
	end

	context "given a credit card no" do
		it "that is valid, should return true" do
			expect(compute.luhn_10(valid_card)).to eq(true)

		end
		it "that is invalid, should return false" do
			expect(compute.luhn_10(invalid_card)).to eq(false)
		end
	end


end

