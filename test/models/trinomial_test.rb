require "test_helper"

describe Trinomial do
  let(:problem) { Trinomial.new }
  describe 'initialize' do
    it "creates two random numbers" do
      # p problem
      problem.must_be_instance_of Trinomial
      problem.root1.must_be_instance_of Integer
      problem.root2.must_be_instance_of Integer
    end
  end

  describe 'generate_plus_plus' do

    it 'returns a hash' do
      # p problem.generate_plus_plus
      problem.generate_plus_plus.must_be_instance_of Hash
    end

    # it 'the hash has three key-value pairs' do
    #   problem.generate_plus_plus.length.must_equal 3
    # end

    # it 'the values of the hash are all integers' do
    #   problem.generate_plus_plus.each do |coefficeient, value|
    #     value.must_be_instance_of Integer
    #   end
    # end
  end

end
