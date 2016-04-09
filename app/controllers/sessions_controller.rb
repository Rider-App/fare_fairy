class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render template: 'users/show', status: :ok, location: @user
    else
      render json: {status: "Invalid credentials."}
    end
  end

end
