class Product < ActiveRecord::Base

  # def sale_message
  #   if price.to_f <= 2
  #     "Discount Item!"
  #   else
  #     "Everyday Value!"
  #   end
  # end

  # def sale_message_class_name
  #   if sale_message == "Discount Item!"
  #     "discount-item"
  #   else
  #     ""
  #   end
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
