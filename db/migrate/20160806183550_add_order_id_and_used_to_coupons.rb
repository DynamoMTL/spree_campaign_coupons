class AddOrderIdAndUsedToCoupons < ActiveRecord::Migration
  def change
    add_column :spree_coupons, :order_id, :integer, default: nil
    add_column :spree_coupons, :used, :boolean, default: false
  end
end
