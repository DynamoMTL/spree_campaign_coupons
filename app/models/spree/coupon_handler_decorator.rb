Spree::PromotionHandler::Coupon.class_eval do
  attr_accessor :coupon

  def apply
   if order.coupon_code.present?
      @coupon = Spree::Coupon.by_code(order.coupon_code.strip.downcase)
      if campaign_coupon_used?
        set_error_code :coupon_code_already_used
      else
        assign_order_to_campaign_coupon

        if promotion.present? && promotion.actions.exists?
          handle_present_promotion(promotion)
        else
          if Spree::Promotion.with_coupon_code(order.coupon_code).try(:expired?)
            set_error_code :coupon_code_expired
          else
            set_error_code :coupon_code_not_found
          end
        end
      end
    end
    self
  end

  def determine_promotion_application_result
    # Check for a matching coupon code
    discount = order.all_adjustments.promotion.eligible.find { |promotion_action|
      promotion = promotion_action.source.promotion

      @coupon_code = order.coupon_code.downcase

      if promotion.is_campaign?
        promotion.campaigns.detect { |campaign| campaign.has_coupon_code?(@coupon_code) }
      elsif promotion.code
        promotion.code.downcase == @coupon_code
      end
    }
    if discount && discount.eligible
      @coupon.used! if @coupon

      order.update_totals
      order.persist_totals
      set_success_code :coupon_code_applied
    else
      # if the promotion exists on an order, but wasn't found above,
      # we've already selected a better promotion
      if order.promotions.with_coupon_code(order.coupon_code)
        set_error_code :coupon_code_better_exists
      else
        # if the promotion was created after the order
        set_error_code :coupon_code_not_found
      end
    end
  end

  private

  def campaign_coupon_used?
    @coupon && @coupon.used?
  end

  def assign_order_to_campaign_coupon
    @coupon.update(order: order) if @coupon
  end
end
