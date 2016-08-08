RSpec.shared_context "checkout to payment" do
  before do
    visit spree.root_path
    click_link "RoR Mug"
    click_button "add-to-cart-button"
    click_button "Checkout"
    fill_in "order_email", :with => "spree@example.com"

    click_button "Continue"
    fill_in "First Name", :with => "John"
    fill_in "Last Name", :with => "Smith"
    fill_in "Street Address", :with => "1 John Street"
    fill_in "City", :with => "City of John"
    fill_in "Zip", :with => "01337"
    select country.name, :from => "Country"
    select state.name, :from => "order[bill_address_attributes][state_id]"
    fill_in "Phone", :with => "555-555-5555"
    # To shipping method screen
    click_button "Save and Continue"
    # To payment screen
    click_button "Save and Continue"
  end
end