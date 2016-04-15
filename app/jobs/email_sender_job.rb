class EmailSenderJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    email = args[0]
    token = args[1]
    AccountMailer.forgot_password(email, token).deliver_now
  end
end
