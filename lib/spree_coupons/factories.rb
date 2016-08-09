include ActionDispatch::TestProcess

FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_coupons/factories'

  factory :coupon_file, class: OpenStruct do
    file { fixture_file_upload(Rails.root.parent.to_s + "/fixtures/coupon_codes.csv") }
  end
end
