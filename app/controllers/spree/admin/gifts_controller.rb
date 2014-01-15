module Spree
  module Admin
    class GiftsController < Spree::Admin::BaseController
      before_filter :init_gift, except: [:index]
      def index
        @gifts = GiftOrder.all.
          page(params[:page]).
          per(params[:per_page] || Spree::Config[:orders_per_page])

      end
      def edit
      end

      def update
        if @gift.update(gift_params)
          @gift.order.update ship_address_id: @gift.friend_address_id
          flash[:notice] = "Successfully updated"
        end

        render :action => :edit
      end


      protected
        def init_gift
         @gift = GiftOrder.find(params[:id])
        end

        def gift_params
          params.require(:gift_order).permit([:friend_email,:friend_name,:status,{friend_address_attributes: [:id, :firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :state_name, :alternative_phone, :company, :state_id, :country_id]}])
        end
    end
  end
end
