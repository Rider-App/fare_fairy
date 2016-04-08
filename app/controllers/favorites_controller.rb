class FavoritesController < ApplicationController
  before_action :set_user

  def show
    @favorites = @user.favorites
  end

  def new
    @favorite = Favorite.new
  end

  def index
    @favorites = @user.favorites
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user = @user
    if @favorite.save
      render :show, status: :created, location: @favorite
    else
      render json: @favroite.errors, status: :unprocessable_entity
    end
  end

  def update
    if @favorite.update(favorite_params)
      render :show, status: :ok, location: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @favorite.destroy
      redirect_to favorites_url, notice: 'Favorite was successfully destroyed.'
    end
  end

  private

    def set_favorite
      @favorite = Favorite.where("token = ?", params[:token]).first
    end

    def favorite_params
      params.require(:favorite).permit(:name, :address, :user_id)
    end

    def set_user
      @user = User.where("token = ?", params[:token]).first
    end











end
