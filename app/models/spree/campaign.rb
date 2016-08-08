class Spree::Campaign < ActiveRecord::Base
  has_many :coupons
  belongs_to :promotion

  def coupon_codes
  end

  def has_coupon_code?(code)
    coupons.find { |c| c.code == code }.present?
  end

  def coupon_codes=(uploaded_coupons_file)
    return unless uploaded_coupons_file.present?
    File.open(uploaded_coupons_file.tempfile, "rb", encoding: 'ISO-8859-1') do |file|
      process_coupon_codes_file(file.readlines)
    end
  end

  private

  def process_coupon_codes_file(coupon_codes)
    return true unless coupon_codes.present?
    coupons << coupon_codes.map { |code| Spree::Coupon.create(code: code.strip) }
    update(coupons_processing: true)
    ProcessCoupons.perform_async(id, coupon_codes)
  end
end
