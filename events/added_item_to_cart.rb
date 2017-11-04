require 'active_model'

class AddedItemToCart
  include ActiveModel::Model

  attr_accessor :product_id, :product_name, :cart_id, :quantity, :timestamp

  def self.topic
    'carts'
  end
end
