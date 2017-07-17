require "test_helper"

describe ATrinomial do
  let(:a_trinomial) { ATrinomial.new }

  it "must be valid" do
    value(a_trinomial).must_be :valid?
  end
end
