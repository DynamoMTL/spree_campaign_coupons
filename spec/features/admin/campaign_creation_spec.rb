require 'spec_helper'

describe "Promotion campaigns", :type => :feature do
  stub_authorization!

  context "create a new campaign", :js => true do

    let!(:promotion) { create(:promotion_with_order_adjustment, is_campaign: true) }

    before(:each) do
      visit spree.admin_path
      click_link "Promotions"
      click_link "Campaigns"
    end

    it "adds a new campaign with the promotion" do
      click_link "New Campaign"
      fill_in "Title", with: "Printed Coupons April 2015"
      select2 "Promo", :from => "Promotion"
      click_button "Create"
      within("tbody") do
        expect(page).to have_content("Printed Coupons April 2015")
        expect(page).to have_content("Promo")
      end
    end

  end

end
