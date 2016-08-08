require 'spec_helper'

describe Spree::Coupon, type: :model do
  include Helpers

  describe "#get_by_code" do
    let!(:coupon) { Spree::Coupon.create!(code: "ABC123") }
    it "returns the Coupon based on the code" do
      expect(Spree::Coupon.by_code("ABC123")).to eql coupon
    end
  end

  describe "#used" do
    let!(:coupon) { create_campaign_coupon_code("campaign12") }
    let!(:order) { create :order_with_line_items, coupon_code: 'campaign12' }

    it "will mark the coupon_code as used when order is complete" do
      Spree::PromotionHandler::Coupon.new(order).apply
      expect(coupon.reload.used).to eq true
    end
  end

  describe "order is assigned" do
    let!(:coupon) { create_campaign_coupon_code("campaign12") }
    let!(:order) { create :order, coupon_code: 'campaign12' }

    it "will assign the order to the coupon_code" do
      Spree::PromotionHandler::Coupon.new(order).apply
      expect(coupon.reload.order).to eql order
    end
  end

end
