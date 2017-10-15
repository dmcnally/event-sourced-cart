require 'active_model'

class PlacedOrder
  include ActiveModel::Model

  attr_accessor :cart_id
end
