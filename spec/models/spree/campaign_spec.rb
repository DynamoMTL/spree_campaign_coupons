require 'spec_helper'

describe Spree::Campaign, type: :model do
  include Helpers

  describe "#coupon_codes" do
    let!(:campaign) { Spree::Campaign.create! }
    it "process the coupon codes from a file" do
      campaign.coupon_codes = FactoryGirl.create(:coupon_file).file

      expect(ProcessCoupons.jobs.size).to eql 1
      expect(campaign.coupons.count).to eql 3

      first_coupon = campaign.coupons.first
      expect(first_coupon.code).to eql "ABC123"
    end
  end

end
