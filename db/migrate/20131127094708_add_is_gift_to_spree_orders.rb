class AddIsGiftToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :is_gift, :boolean, default: false
  end
end
