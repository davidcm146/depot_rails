class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    logger.info "Calculating total price for line item: #{self.inspect}"
    product.price * quantity
  end
end
