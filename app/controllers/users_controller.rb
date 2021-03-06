class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_forgetful_user, only: :forgot_password

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'show.json.jbuilder', status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  end

  def update
    if @user.update(user_params)
      render 'show.json.jbuilder', status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      token = params[:token]
      if token
        user = User.joins(:session_tokens).where("token = ?", token).first
        if user
          @user = user
          @token = token
        else
          render json: {status: :invalid_token}
        end
      else
        render json: {status: :token_needed}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :password, :token, :email)
    end


end
