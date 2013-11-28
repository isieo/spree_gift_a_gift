class CreateSpreeGiftOrders < ActiveRecord::Migration
  def change
    create_table :spree_gift_orders do |t|
      t.string :friend_name
      t.string :friend_email
      t.integer :friend_address_id
      t.string :redeem_code
      t.string :status
      t.integer :order_id
    end
  end
end
