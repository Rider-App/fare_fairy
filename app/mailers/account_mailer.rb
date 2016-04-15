class AccountMailer < ApplicationMailer

  def forgot_password(email, token)
    @password_reset_link = "http://rider-app.firebaseapp.com/#/password_reset/?token=#{token}"

    mail to: email, subject: "Updates to your Rider Account"
  end
end
