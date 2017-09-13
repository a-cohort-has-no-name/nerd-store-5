class Supplier < ApplicationRecord
  has_many :products
  # def products
  #   puts "get all the products with a supplier_id that matches this supplier"
  #   Supplier.find_by(id: supplier_id)
  # end
end
