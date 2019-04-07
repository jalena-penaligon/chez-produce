require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({"1" => 2, "2" => 1}) }
  describe "#total_count" do
    it "counts number of items in a cart" do

      expect(subject.total_count).to eq(3)
    end
  end
end
