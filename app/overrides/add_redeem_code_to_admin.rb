Deface::Override.new(:virtual_path => 'spree/admin/shared/_order_tabs',
  :name => 'add_redeem_code_to_order_tab_summary',
  :insert_after => 'dd#payment_status',
  :text => "
      <dt>Gift: </dt>
      <dd><span><%= @order.is_gift? ? 'YES': 'no'%></span></dd>
      <%if @order.is_gift?  && @order.gift%>
        <dt><%= Spree.t(:redeem_code) %>: </dt>
        <dd id='redeem_code'><span><%= @order.gift.redeem_code%></span></dd>
      <%end%>
      ")

Deface::Override.new(:virtual_path => 'spree/admin/shared/_order_tabs',
  :name => 'add_redeem_code_to_order_tab_summary',
  :insert_after => 'dd#payment_status',
  :text => "
      <dt>Gift: </dt>
      <dd><span><%= @order.is_gift? ? 'YES': 'no'%></span></dd>
      <%if @order.is_gift? && @order.gift %>
        <dt><%= Spree.t(:redeem_code) %>: </dt>
        <dd id='redeem_code'><span><%= @order.gift.redeem_code%></span></dd>
      <%end%>
      ")

Deface::Override.new(:virtual_path => 'spree/admin/orders/edit',
  :name => 'add_gift_field_to_admin_order_edit',
  :insert_after => 'div[data-hook="admin_order_edit_header"]',
  :text => "
  <%if @order.is_gift? && @order.gift %>
      <div style='background-color: #ddadb6;'><h3 style='color: #EEE'><%=link_to edit_admin_gift_path(@order.gift) do%><%=Spree.t(:order_is_a_gift)%><%end%></h3></div>
  <%end%>
      ")

Deface::Override.new(:virtual_path => 'spree/admin/shared/_tabs',
  :name => 'add_gift_field_to_admin_shared_tabs',
  :insert_after => "erb[loud]:contains('tab :orders')",
  :text => "
      <%= tab :gifts %>
      ")
