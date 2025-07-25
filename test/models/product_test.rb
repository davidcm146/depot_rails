require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  def new_product(image_url)
    Product.new(title:       "My Book Title",
                         description: "yyy",
                         price: 1,
                         image_url:   image_url)
  end
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "Product price must be positive" do
    product = Product.new(title:       "My Book Title",
                         description: "yyy",
                         image_url:   "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.1"],
      product.errors[:price]
 
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.1"],
      product.errors[:price]
 
    product.price = 1
    assert product.valid?
  end

  test "image url must be in correct format" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} must be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} must be invalid"
    end
  end

  test "product title must be unuique" do
    product = Product.new(title:       products(:ruby).title,
                         description: "yyy",
                         price: 1,
                         image_url:   "zzz.jpg")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
