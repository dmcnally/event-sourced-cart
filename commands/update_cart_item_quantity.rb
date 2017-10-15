require 'active_model'
require_relative '../events/updated_cart_item_quantity'
require_relative '../models/cart'

class UpdateCartItemQuantity
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :product_id, :quantity, :session

  validates :product_id, :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validate :validate_product_exists

  def execute(stream)
    if valid?
      # add the item to the cart
      cart = Cart.new(session)
      cart.update_item_quantity(product_id: product_id, quantity: quantity)
      # add the event to the stream
      stream.push UpdatedCartItemQuantity.new(
        product_id: product_id,
        quantity: quantity,
        cart_id: cart.id
      )
    end
  end

  private

  def validate_product_exists
    unless Product.exist?(product_id)
      errors.add(:product_id, "is invalid")
    end
  end
end
