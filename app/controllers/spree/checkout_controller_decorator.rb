module Spree


  CheckoutController.class_eval do
    Spree::PermittedAttributes.checkout_attributes << :is_gift
    Spree::PermittedAttributes.checkout_attributes << {:gift_attributes => [:id,:friend_name,:friend_email,:friend_message]}
    append_before_filter :check_for_gift
    def check_for_gift
      if params[:order] && params[:order][:gift_attributes]
        params[:order][:gift_attributes][:id] = @order.gift.id if @order.gift
      end
    end

  end
end
