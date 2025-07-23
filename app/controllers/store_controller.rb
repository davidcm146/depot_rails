class StoreController < ApplicationController
  include CountAccessStore
  def index
    @products = Product.order(:title)
    @counter = get_count_access
  end
end
