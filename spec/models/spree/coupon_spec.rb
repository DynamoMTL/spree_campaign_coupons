require 'spec_helper'

describe Spree::Coupon, type: :model do

  describe "#get_by_code" do
    let!(:coupon) { Spree::Coupon.create!(code: "ABC123") }
    it "returns the Coupon based on the code" do
      expect(Spree::Coupon.by_code("ABC123")).to eql coupon
    end
  end

  describe "#used" do
    it "will mark the coupon_code as used when order is complete"
  end

  describe "order is assigned" do
    it "will assign the order to the coupon_code"
  end

end
