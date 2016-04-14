class EmailSenderJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    token = args[0]
    AccountMailer.forgot_password(token).deliver_now
  end
end
