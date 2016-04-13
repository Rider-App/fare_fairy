class AccountMailer < ApplicationMailer

  def forgot_password(address)
    @greeting = "Hi"

    mail to: address, subject: "Updates to your Rider Account"
  end
end
