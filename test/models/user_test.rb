require "test_helper"

describe User do
  let(:user) { User.new( username: "test_name" ) }
  let(:no_name_user) { User.new }
  let(:user_name_short) { User.new(username: "ab") }
  let(:user_name_3) { User.new(username: "cat") }


  describe 'validations' do

    it "must have a username" do
      user.valid?.must_equal true
    end

    it 'wont allow missing username' do
      no_name_user.valid?.must_equal false
    end

    it 'wont allow user name less than 3 chars' do
      user_name_short.valid?.must_equal false
    end

    it 'will allow username with 3 chars' do
      user_name_3.valid?.must_equal true
    end
  end

end
