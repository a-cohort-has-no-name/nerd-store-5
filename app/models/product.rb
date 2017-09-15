class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images
  has_many :orders

  # def supplier
  #   puts "get the supplier instance that matches this product"
  #   Product.where(supplier_id: id)
  # end

  def tax
    price.to_f * 0.09
  end

  def total
    price.to_f + tax
  end

  def discounted?
    price.to_f <=2
  end

end
