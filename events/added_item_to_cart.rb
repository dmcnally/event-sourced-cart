require 'active_model'

class AddedItemToCart
  include ActiveModel::Model

  attr_accessor :product_id, :cart_id, :quantity

  def self.topic
    'carts'
  end
end
