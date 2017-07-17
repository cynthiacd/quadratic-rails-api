require "test_helper"

describe SpecialTrinomial do
  let(:special_trinomial) { SpecialTrinomial.new }

  it "must be valid" do
    value(special_trinomial).must_be :valid?
  end
end
