require 'active_model'

class RemovedItemFromCart
  include ActiveModel::Model

  attr_accessor :product_id, :product_title, :cart_id, :timestamp

  def self.topic
    'carts'
  end
end
