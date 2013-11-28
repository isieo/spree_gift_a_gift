module Spree
  Address.class_eval do
    has_one :gift_order,foreign_key: :friend_address_id

  end
end
