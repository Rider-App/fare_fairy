class FavoritesController < ApplicationController
  before_action :set_user
  before_action :authenticate_user_favorite, only: [:update, :destroy]

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
      render json: {status: :created}
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def update
    if @favorite.update(favorite_params) && @favorite.user == @user
      render :show, status: :ok, location: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @favorite.destroy
      render json: {status: :successfully_destroyed}
    end
  end

  private

    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    def favorite_params
      params.require(:favorite).permit(:name, :address, :user_id)
    end

    def set_user
      token = params[:token]
      if token
        if User.where("token = ?", token).first
          @user = User.where("token = ?", token).first
        else
          render json: {status: :invalid_token}
        end
      else
        render json: {status: :token_needed}
      end

    end

    def authenticate_user_favorite
      @favorite = Favorite.find(params[:id])
      @favorites = @user.favorites
      render json: {status: :unprocessable_entity} unless @favorites.include?(@favorite)
    end


end
