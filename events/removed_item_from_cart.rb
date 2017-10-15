require 'active_model'

class RemovedItemFromCart
  include ActiveModel::Model

  attr_accessor :product_id, :cart_id
end
