class AddGiftDetailsToSpreeGiftOrders < ActiveRecord::Migration
  def change
    add_column :spree_gift_orders, :sent_at, :datetime
    add_column :spree_gift_orders, :receipent_notes, :text
    add_column :spree_gift_orders, :variant_id, :integer
  end
end
