class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      @token = SessionToken.create(user_id: @user.id, token: SecureRandom.hex)
      render 'users/show.json.jbuilder', status: :ok, location: @user
    else
      render json: {status: "Invalid credentials"}
    end
  end

  def destroy
    token = SessionToken.where("token = ?", params[:token]).first
    if token
      token.destroy
      render json: {status: "Successfully logged out"}
    else
      render json: {status: "Invalid token"}
    end
  end

end
