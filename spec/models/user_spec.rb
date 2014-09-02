require 'rails_helper'

RSpec.describe User, :type => :model do

  subject(:user) { FactoryGirl.create(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  describe "validations" do

    [:name, :email, :address].each do |attr|
      it "is invalid without a #{attr}" do
        expect(FactoryGirl.build(:user, attr => nil)).to_not be_valid
      end
    end
  end

  describe "User#user_details" do
    it 'should concatenate the user email and address' do
      expect(user.user_details).to eq("#{user.email} #{user.address}")
    end
  end
end
