class CreateSpreeCampaigns < ActiveRecord::Migration
  def change
    create_table :spree_campaigns do |t|
      t.integer :promotion_id
      t.string :title
      t.timestamps
    end
  end
end
