require 'active_model'

class PlacedOrder
  include ActiveModel::Model

  attr_accessor :cart_id, :order_id, :timestamp, :line_items

  def self.topic
    'orders'
  end
end
