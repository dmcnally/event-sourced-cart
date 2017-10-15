require 'active_model'

class LineItem
  include ActiveModel::Model

  attr_accessor :product_id, :quantity

  def product
    Product.all.find { |p| p.id == Integer(product_id) }
  end

  def total
    quantity * product.price
  end
end
