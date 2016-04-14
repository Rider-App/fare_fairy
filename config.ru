# This file is used by Rack-based servers to start the application.

require 'rack'
require 'rack/cors'
use Rack::Cors do
  allow do
    # origins 'rider-app.firebaseapp.com', 'localhost:3000', 'localhost:3001'
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :delete, :patch]
  end
end

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
