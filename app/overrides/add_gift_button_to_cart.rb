Deface::Override.new(:virtual_path => 'spree/orders/edit',
  :name => 'add_gift_button_to_cart',
  :insert_bottom => 'div[data-hook="cart_buttons"]',
  :text => "
      <%= button_tag :class => 'product-btn gift', :id => 'gift-link', :name => 'gift' do %>
        <%= Spree.t(:gift) %>
      <% end %>
  ")
