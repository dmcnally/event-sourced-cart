require 'active_model'

class UpdatedCartItemQuantity
  include ActiveModel::Model

  attr_accessor :product_id, :cart_id, :quantity
end
