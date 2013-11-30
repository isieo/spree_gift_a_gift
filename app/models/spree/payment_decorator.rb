module Spree
  Payment.class_eval do
    def update_order
      order.payments.reload
      order.update!
      if order.paid?
        if order.is_gift? && !order.gift.nil? && order.gift.sent_at.nil?
           Spree::OrderMailer.redeem_code_email(order.id).deliver
        end
      end
    end
  end
end
