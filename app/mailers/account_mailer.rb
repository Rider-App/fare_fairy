class AccountMailer < ApplicationMailer

  def forgot_password(token)
    @greeting = "Hi"
    @token = token

    mail to: 'katestudwell@gmail.com', subject: "Updates to your Rider Account"
  end
end
