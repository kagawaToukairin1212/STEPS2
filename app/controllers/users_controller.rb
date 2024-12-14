class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path
      else
        render :new
      end
    end

    def mypage
      @user = current_user # ログイン中のユーザー情報を取得
      @sheets = current_user.sheets # 全シートを取得
    end

    def profile
      @user = current_user # ログイン中のユーザー情報を取得
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
