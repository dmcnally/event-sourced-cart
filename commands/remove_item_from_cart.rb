require 'active_model'
require_relative '../events/removed_item_from_cart'
require_relative '../models/cart'

class RemoveItemFromCart
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :product_id, :session

  validates :product_id, presence: true
  validate :validate_product_exists

  def execute(stream)
    if valid?
      # add the item to the cart
      cart = Cart.new(session)
      cart.remove_item(product_id: product_id)
      # add the event to the stream
      stream.push RemovedItemFromCart.new(
        product_id: product_id,
        cart_id: cart.id,
        timestamp: Time.now.utc
      )
      # return success
      true
    end
  end

  private

  def validate_product_exists
    unless Product.exist?(product_id)
      errors.add(:product_id, "is invalid")
    end
  end
end
