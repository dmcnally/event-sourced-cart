require 'active_model'
require_relative '../events/added_item_to_cart'
require_relative '../models/cart'

class AddItemToCart
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :product_id, :quantity, :session

  validates :product_id, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }
  validate :validate_product_exists

  def execute(stream)
    if valid?
      # add the item to the cart
      cart = Cart.new(session)
      cart.add_item(product_id: product_id, quantity: quantity)
      # add the event to the stream
      stream.push AddedItemToCart.new(
        product_id: product_id,
        quantity: quantity,
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
