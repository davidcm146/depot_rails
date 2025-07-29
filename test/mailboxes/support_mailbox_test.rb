require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  test "Create support request from sent email" do
    receive_inbound_email_from_mail(
      to: 'support@example.com',
      from: 'test1@example.com',
      subject: "Hello world!",
      body: "Hello")

    support_request = SupportRequest.last
    assert_equal "test1@example.com", support_request.email
    assert_equal "Hello world!", support_request.subject
    assert_equal "Hello", support_request.body
    assert_nil support_request.order
  end

  test "Create support request with recent order" do
    recent_order = orders(:another_one)
    receive_inbound_email_from_mail(
      to: "support@example.com",
      from: recent_order.email,
      subject: "Need help",
      body: "I can't figure out how to check out!!"
      )
    support_request = SupportRequest.last
    assert_equal recent_order.email, support_request.email
    assert_equal "Need help", support_request.subject
    assert_equal "I can't figure out how to check out!!", support_request.body
    assert_equal recent_order, support_request.order
  end
end
