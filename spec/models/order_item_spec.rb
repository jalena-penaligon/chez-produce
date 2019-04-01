require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

end
