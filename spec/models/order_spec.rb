require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'relationships' do
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
    it { should belong_to :user }
  end

end