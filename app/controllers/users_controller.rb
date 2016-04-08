class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
      respond_to do |format|
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  end

  def update
    if @user.update(user_params)
      # redirect_to @user, notice: 'User was successfully updated.'
      render :show, status: :ok, location: @user
    else
      # render :edit
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # @user = User.find(params[:id])
      @user = User.where("token = ?", params[:token]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :password, :token, :email)
    end


    #valid update URL for user 9:
    # http://localhost:3000/users/9?user[email]=joe@joe.com&token=399b16af4e15b7498119f1addf8cebb4

    # probably don't need the id number (9 in above)



end
