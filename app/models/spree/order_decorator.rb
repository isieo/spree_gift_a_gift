module Spree
  Order.class_eval do
    has_one :gift, class_name: 'GiftOrder'
    accepts_nested_attributes_for :gift
    insert_checkout_step :gift, before: :address

    def can_ship?
      return self.complete? || self.resumed? || self.awaiting_return? || self.returned? if !self.is_gift? || self.gift.nil?
      self.complete? || self.resumed? || self.awaiting_return? || self.returned? || self.gift.redeemed?
    end
  end
end
