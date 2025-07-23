class Product < ApplicationRecord
  has_many :line_items
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {  with: %r{\.(gif|jpg|png)\z}i, message: "must be file PNG, JPG or GIF" }
  validates :price, numericality: { greater_than_or_equal_to: 0.1 }
  before_destroy :ensure_not_ref_by_any_line_item
  
  private

  def ensure_not_ref_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
