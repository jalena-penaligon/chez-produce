require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
    it { should belong_to :user }
  end

end
