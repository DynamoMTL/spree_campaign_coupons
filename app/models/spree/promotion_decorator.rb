Spree::Promotion.class_eval do
  has_many :campaigns

  def self.with_coupon_code(coupon_code)
    coupon = Spree::Coupon.by_code(coupon_code.strip.downcase)
    return coupon.promotion if coupon
    where("lower(#{self.table_name}.code) = ?", coupon_code.strip.downcase).first
  end

  def self.for_campaigns
    where(is_campaign: true)
  end
end
