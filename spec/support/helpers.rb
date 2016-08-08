module Helpers

  def create_basic_coupon_promotion(code)
   promotion = Spree::Promotion.create!(:name       => code.titleize,
                                         :code       => code,
                                         :starts_at  => 1.day.ago,
                                         :expires_at => 1.day.from_now)

   calculator = Spree::Calculator::FlatRate.new
   calculator.preferred_amount = 10

   action = Spree::Promotion::Actions::CreateItemAdjustments.new
   action.calculator = calculator
   action.promotion = promotion
   action.save

   promotion.reload # so that promotion.actions is available
  end

  def create_campaign_coupon_code(code)
    promotion = Spree::Promotion.create!(:name       => code.titleize,
                                         :is_campaign => true,
                                         :starts_at  => 1.day.ago,
                                         :expires_at => 1.day.from_now)

    calculator = Spree::Calculator::FlatRate.new
    calculator.preferred_amount = 10

    action = Spree::Promotion::Actions::CreateItemAdjustments.new
    action.calculator = calculator
    action.promotion = promotion
    action.save

    promotion.reload

    campaign = Spree::Campaign.create(promotion:promotion)
    coupon = Spree::Coupon.create(code: code, campaign: campaign)
  end

end