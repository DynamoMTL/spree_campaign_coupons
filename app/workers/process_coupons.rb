class ProcessCoupons
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  #
  # Process the coupons, create a `Spree::Coupon` if not already exist with the
  #  provided code.
  #
  # @coupons A String Array containing the codes
  def perform(campaign_id, coupons)
    campaign = Spree::Campaign.find(campaign_id)
    coupons.each do |code|
      campaign.coupons.find_or_create_by(code: code.strip)
    end
    campaign.update_attribute(:coupons_processing,false)
  end
end
