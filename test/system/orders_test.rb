require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "Check dynamic fields" do
    visit store_index_url
    click_on "Add to Cart", match: :first 
    click_on "Checkout"                                                  
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Po number'
    select 'Check', from: 'Pay type'
    assert has_field? 'Routing number'
    assert has_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Po number'
    select 'Credit card', from: 'Pay type'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_field? 'Credit card number'
    assert has_field? 'Expiration date'
    assert has_no_field? 'Po number'
    select 'Purchase order', from: 'Pay type'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_field? 'Po number'
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

   test "check order and delivery" do
    LineItem.delete_all
    Order.delete_all
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Checkout'
    fill_in 'Name', with: 'User hehe'
    fill_in 'Address', with: '123'
    fill_in 'Email', with: 'quachhuycm@gmail.com'
    
    select 'Check', from: 'Pay type'
    fill_in "Routing number", with: "123456"
    fill_in "Account number", with: "987654"
    
    click_button "Place Order"
    assert_text 'Thank you for your order'
    
    perform_enqueued_jobs
    perform_enqueued_jobs
    assert_performed_jobs 2
    
    orders = Order.all
    assert_equal 1, orders.size
    
    order = orders.last
    assert_equal "User hehe",      order.name
    assert_equal "123",  order.address
    assert_equal "quachhuycm@gmail.com", order.email
    assert_equal "Check",            order.pay_type
    assert_equal 1, order.line_items.size
    
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["quachhuycm@gmail.com"],                 mail.to
    assert_equal 'quachhuycm@gmail.com',       mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
 end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    accept_confirm { click_on "Destroy this order", match: :first }

    assert_text "Order was successfully destroyed"
  end
end
