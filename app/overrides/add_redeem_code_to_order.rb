Deface::Override.new(:virtual_path => 'spree/shared/_order_details',
  :name => 'add_redeem_code_to_order',
  :insert_after => 'table',
  :original => 'db734ed0068b0eb61a5e480f3f47cba472453b69',
  :text => '
  <div class="row" id="redeem-code">
    <% if @order.is_gift?%>
      <% if @order.paid? %>
        <div class="large-12 columns panel">
          <h3><%= Spree.t(:redeem_code) %></h3>
          <p><%== Spree.t(:redeem_instruction, redeem_url: link_to(redeem_index_url,redeem_index_url)) %></p>
          <div class="centered"><input style="background-color: #3f3f3f;color:#FEFEFE;font-size:3em;width:250px;text-align:center" value="<%= @order.gift.redeem_code%>" readonly="readonly"></div>
        </div>
      <%else%>
        <div class="large-12 columns panel">
          <h3><%= Spree.t(:redeem_code) %></h3>
          <p><%== Spree.t(:order_not_paid_yet) %></p>
        </div>
      <%end%>
    <% end %>
  </div>')
