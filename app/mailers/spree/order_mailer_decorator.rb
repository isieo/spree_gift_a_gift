module Spree
  OrderMailer.class_eval do
    def redeem_code_email(order_id)
      @order = Spree::Order.find(order_id)
      subject = "[#{Spree::Config[:site_name]}] Gift from #{@order.bill_address.first_name} #{@order.bill_address.last_name}"
      @order.gift.update(sent_at: Time.now)
      mail(:to => "#{@order.gift.friend_email}", :from => from_address, :subject => subject)
    end
  end
end
