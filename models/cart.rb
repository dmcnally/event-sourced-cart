require 'securerandom'

require_relative 'line_item'

class Cart
  ID_KEY = 'id'.freeze
  ITEMS_KEY = 'items'.freeze

  def initialize(session)
    @session = session
    # set an ID for the cart
    @session[ID_KEY] ||= SecureRandom.uuid
    # set our default hash for items
    @session[ITEMS_KEY] ||= Hash.new
    @session[ITEMS_KEY].default = 0
  end

  def id
    @session[ID_KEY]
  end

  def total
    line_items.map(&:total).reduce(:+)
  end

  def size
    line_items.map(&:quantity).reduce(:+)
  end

  def line_items
    @session[ITEMS_KEY].each_with_object([]) do |(product_id, quantity), result|
      if quantity > 0
        result << LineItem.new(product_id: product_id, quantity: quantity)
      end
    end
  end

  def add_item(quantity:, product_id:)
    @session[ITEMS_KEY][product_id] += Integer(quantity)
  end

  def remove_item(product_id:)
    @session[ITEMS_KEY][product_id] = 0
  end

  def update_item_quantity(quantity:, product_id:)
    @session[ITEMS_KEY][product_id] = Integer(quantity)
  end

  def reset!
    @session[ID_KEY] = nil
    @session[ITEMS_KEY] = {}
  end

  def empty?
    @session[ITEMS_KEY].values.none? { |v| v > 0 }
  end
end
