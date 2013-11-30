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

      @gift.transaction do
        if @gift.update(gift_params)

          if order_params
            order_params[:line_items_attributes].each do |k,li|
              order_line = @gift.order.line_items.find(li[:id])
              next if !order_line
              next if order_line.variant.product.variants.where(id: li[:variant_id]).empty?
              order_line.update!(variant_id: li[:variant_id])
            end
            @gift.order.create_proposed_shipments
          end
          flash[:notice] = "Successfully used your redeem code. You may be contacted by our customer support staff for confirmation."
          @gift.update(status: 'redeemed')

         redirect_to root_path
         return
        end
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
        params.require(:gift_order).permit([:friend_email,:friend_name,:receipent_notes,{friend_address_attributes: [:id, :firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :state_name, :alternative_phone, :company, :state_id, :country_id]}])
      end
      def order_params
        return nil if !params[:order]
        params.require(:order).permit([{line_items_attributes: [:id,:variant_id]}])
      end
  end
end
