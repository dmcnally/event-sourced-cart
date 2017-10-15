require 'active_model'
require_relative '../events/placed_order'
require_relative '../models/cart'

class PlaceOrder
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :session

  validate :validate_cart_isnt_empty

  def execute(stream)
    if valid?
      # reset the cart
      cart.reset!
      # add the event to the stream
      stream.push PlacedOrder.new(
        cart_id: cart.id
      )
      # return success
      true
    end
  end

  private

  def cart
    @cart ||= Cart.new(session)
  end

  def validate_cart_isnt_empty
    if cart.empty?
      errors.add(:base, "Cart is empty")
    end
  end
end
