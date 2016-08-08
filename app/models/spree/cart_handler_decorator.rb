Spree::PromotionHandler::Cart.class_eval do

  def activate
    promotions.each do |promotion|
      next if promotion.is_campaign
      if (line_item && promotion.eligible?(line_item)) || promotion.eligible?(order)
        promotion.activate(line_item: line_item, order: order)
      end
    end
  end

end
