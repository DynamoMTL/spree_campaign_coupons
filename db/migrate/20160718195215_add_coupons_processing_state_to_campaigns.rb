class AddCouponsProcessingStateToCampaigns < ActiveRecord::Migration
  def change
    add_column :spree_campaigns, :coupons_processing, :boolean
  end
end
