class StoreController < ApplicationController
  include CountAccessStore
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    @counter = get_count_access
  end
end
