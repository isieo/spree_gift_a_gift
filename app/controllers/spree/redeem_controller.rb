module Spree
  class RedeemController < Spree::StoreController
    before_action :init_gift, except: [:index]
    def index
      if params[:redeem_code]
        gift = GiftOrder.find_by(:redeem_code => params[:redeem_code])
        if gift && gift.order.paid?
          redirect_to redeem_path(params[:redeem_code])
        else
          flash[:alert] = "Invalid Coupon Code"
        end
      end
    end
    def edit
    end

    def update
      if @gift.status  == 'redeemed'
        redirect_to root_path
        return
      end
      if @gift.update(gift_params)
        flash[:notice] = "Successfully used your redeem code. You may be contacted by our customer support staff for confirmation."
        @gift.update(status: 'redeemed')
        redirect_to root_path
        return
      end

      @order = @gift.order
      render :action => :show
    end

    def show
      @order = @gift.order
    end


    protected
      def init_gift
       @gift = GiftOrder.find_by(:redeem_code => params[:id])
       @gift = nil if @gift && !@gift.order.paid?
       redirect_to redeem_index_path if !@gift
      end

      def gift_params
        a = params.require(:gift_order).permit([{order_attribute: {line_items_attributes: [:id,:variant_id]} },:friend_email,:friend_name,:receipent_notes,{friend_address_attributes: [:id, :firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :state_name, :alternative_phone, :company, :state_id, :country_id]}])
      end
  end
end
