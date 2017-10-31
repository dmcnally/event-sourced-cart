require 'yaml'
require 'active_model'

class Product
  class << self
    def all
      @products ||= begin
        path = File.join(File.dirname(__FILE__), '../config/products.yml')
        YAML.load_file(path).map { |attrs| new(attrs) }
      end
    end

    def find(id)
      all.find { |p| Integer(p.id) == Integer(id) }
    end

    def exist?(id)
      all.any? { |p| Integer(p.id) == Integer(id) }
    end
  end

  include ActiveModel::Model

  attr_accessor :id, :title, :price, :photo
end
