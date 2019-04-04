require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:inactive_merchant)
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :orders }
  end

  describe 'class methods' do
    it '.active_merchants returns active merchants' do

      expect(User.active_merchants).to eq([@merchant_1, @merchant_2])
    end
  end

end
