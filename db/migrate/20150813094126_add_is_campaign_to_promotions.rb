class AddIsCampaignToPromotions < ActiveRecord::Migration
  def change
    add_column :spree_promotions, :is_campaign, :boolean, :default => false
  end
end
