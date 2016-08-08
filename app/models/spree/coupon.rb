class Spree::Coupon < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :order
  has_one :promotion, through: :campaign

  validates :code, presence: true, uniqueness: true

  def used!(order)
    update(order: order, used: true)
  end

  def self.by_code(code)
    where("lower(code) = ?", code.strip.downcase).first
  end

end
