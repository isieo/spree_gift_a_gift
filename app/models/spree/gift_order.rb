module Spree
  class GiftOrder < ActiveRecord::Base
    belongs_to :order
    belongs_to :friend_address, class_name: "Spree::Address"
    accepts_nested_attributes_for :friend_address
    validate :friend_name, presence: true, if: :fields_not_blank
    validate :friend_email, presence: true, if: :fields_not_blank
    validate :friend_message, presence: true, if: :fields_not_blank
    before_save :generate_redeem_code

    def redeemed?
      self.status == :redeemed
    end

    def fields_not_blank
      return true if !self.friend_name.nil?
      return true if !self.friend_email.nil?
      return true if !self.friend_message.nil?
    end

    def generate_redeem_code
      return if !redeem_code.nil?
      #list of non confusing alpha numeric, removed o O 0 l I
      non_confusing_alphanum = ["a", "b", "c", "d", "e", "f",
                      "g", "h", "i", "j", "k", "m",
                      "n", "p", "q", "r", "s", "t",
                      "u", "v", "w", "x", "y", "z",
                      "A", "B", "C", "D", "E", "F",
                      "G", "H", "J", "K", "L", "M",
                      "N", "P", "Q", "R", "S", "T",
                      "U", "V", "W", "X", "Y", "Z",
                      "1", "2", "3", "4", "5", "6",
                      "7", "8", "9"]
      length = 15
      begin
        self.redeem_code = (0...length).map{ non_confusing_alphanum[rand(non_confusing_alphanum.count)] }.join
        length +=1 #increase length by 1 if collision is detected.
      end while self.class.where(:redeem_code=>self.redeem_code).exists?
    end
  end
end
