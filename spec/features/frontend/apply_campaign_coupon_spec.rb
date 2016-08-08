require 'spec_helper'

describe "Apply Campaign Coupon", type: :feature, js: true do
  include_context "storefront"
  include_context "checkout to payment"  
  include Helpers

  let!(:coupon_code) { create_campaign_coupon_code("campaign12") }

  context "with valid coupon" do
    it "will apply the promotion" do
      fill_in "order_coupon_code", :with => "campaign12"
      click_button "Save and Continue"
      expect(page).to have_content("Promotion (Campaign12)   -$10.00")
    end
  end

  context "will not apply the promotion" do
    it "with an already used coupon code" do
      coupon_code.used!

      fill_in "order_coupon_code", :with => "campaign12"
      click_button "Save and Continue"
      expect(page).to have_content(Spree.t(:coupon_code_already_used))
    end
  end

end
