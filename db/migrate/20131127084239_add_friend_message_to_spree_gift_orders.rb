class AddFriendMessageToSpreeGiftOrders < ActiveRecord::Migration
  def change
    add_column :spree_gift_orders, :friend_message, :text
  end
end
