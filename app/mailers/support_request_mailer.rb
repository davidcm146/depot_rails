class SupportRequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_request_mailer.respond.subject
  #
  def respond(support_request)
    @support_request = support_request
    mail to: @support_request.email, subject: "Response to your support request: #{@support_request.subject}"
  end
end
