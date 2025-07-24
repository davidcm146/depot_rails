class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
      current_item.quantity = 1
    end
    current_item
  end

  def update_quantity(line_item_id, quantity)
    line_item = line_items.find(line_item_id)
    if line_item
      line_item.quantity = quantity
    end
    line_item
  end
end
