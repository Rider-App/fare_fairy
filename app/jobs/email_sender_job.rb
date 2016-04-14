class EmailSenderJob < ActiveJob::Base
  queue_as :default


  def perform(*args)
      SessionToken.create(user_id:1, token:3)
  end
end
