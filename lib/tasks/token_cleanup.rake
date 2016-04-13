desc "This task is called by the Heroku scheduler add-on"
task :token_cleanup => :environment do
  SessionToken.cleanup_old_tokens
end
