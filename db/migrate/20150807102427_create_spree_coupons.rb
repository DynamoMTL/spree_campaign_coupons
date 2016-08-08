class CreateSpreeCoupons < ActiveRecord::Migration
  def change
    create_table :spree_coupons do |t|
      t.string :code
      t.integer :campaign_id
      t.timestamps
    end
  end
end
