# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product
  #has_many :products, class_name: "Product", through: :cart_items

  def add_product_to_cart(product)
    ci = cart_items.build
    ci.product = product
    ci.quantity = 1
    ci.save
  end

  def total_price
    sum = 0
    cart_items.each do |item|
      if item.product.price.present?
        sum += item.quantity * item.product.price
      end
    end
    sum
  end

  def clean!
    cart_items.destroy_all
  end
end
