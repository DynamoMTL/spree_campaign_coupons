class Spree::Campaign < ActiveRecord::Base
  has_many :coupons
  belongs_to :promotion
  after_save :process_coupon_codes_file

  def coupon_codes
  end

  def has_coupon_code?(code)
    coupons.find { |c| c.code == code }.present?
  end

  def coupon_codes=(uploaded_coupons_file)
    return unless uploaded_coupons_file.present?
    File.open(uploaded_coupons_file.tempfile, "rb", encoding: 'ISO-8859-1') do |file|
      @coupons = file.readlines
    end
  end

  private

  def process_coupon_codes_file
    return true unless @coupons.present?
    update_attribute(:coupons_processing, true)
    ProcessCoupons.perform_async(id, @coupons)
  end
end
