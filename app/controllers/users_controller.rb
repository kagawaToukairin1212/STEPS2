class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path, success: t("users.create.success")
      else
        flash.now[:danger] = t("users.create.failure")
        render :new, status: :unprocessable_entity
      end
    end

    def mypage
      @user = current_user # ログイン中のユーザー情報を取得
      # シートに紐づく評価スコアを取得
      @sheets = current_user.sheets.includes(goals: :evaluation_scores)
    end

    def profile
      @user = current_user # ログイン中のユーザー情報を取得
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
