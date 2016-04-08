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

  # def destroy
    # --------- FEE: if someone logs out, we'll kill the session from the front end instead of the sessions controller
  # end





end
