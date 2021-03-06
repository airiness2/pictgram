class PicturesController < ApplicationController

    before_action :set_picture, only: [:show, :edit, :update, :destroy]

    before_action :sign_in_user

    before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}


    def index
      @pictures = Picture.all
    end

    def new
      if params[:back]
        @picture = Picture.new(picture_params)
      else
        @picture = Picture.new
      end
    end

    def create
      @picture = Picture.new(picture_params)
      @picture.user_id = current_user.id
      if @picture.save
        redirect_to pictures_path, notice: "画像をアップロードしました!"
      else
        render 'new'
      end
    end

    def show
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end

    def edit
    end

    def update
      if @picture.update(picture_params)
        redirect_to pictures_path, notice: "投稿を編集しました！"
      else
        render 'edit'
      end
    end

    def destroy
      @picture.destroy
      redirect_to pictures_path, notice: "画像を削除しました！"
    end


    def confirm
      @picture = Picture.new(picture_params)
      @picture.user_id = current_user.id
      render :new if @picture.invalid?
    end

    private

    def picture_params
      params.require(:picture).permit(:content, :user_id, :image, :image_cache)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def sign_in_user
      redirect_to new_user_path unless logged_in?
    end


    def ensure_correct_user
      @picture = Picture.find_by(id: params[:id])
      if current_user.id != @picture.user_id
        flash[:notice] = "権限がありません"
        redirect_to root_path
      end
    end

end
