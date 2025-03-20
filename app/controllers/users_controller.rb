class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]
    before_action :set_user, only: %i[profile edit update]

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

    def edit
      @user = current_user
    end

    def update
      if @user.update(user_update_params)
        redirect_to profile_path, success: t("users.update.success")
      else
        flash.now[:danger] = @user.errors.full_messages.join(", ")  # 具体的なエラーを表示
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = current_user  # ログイン中のユーザー情報をセット！
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_update_params
      permitted_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

      # パスワードが空の場合は更新しないように除外
      if permitted_params[:password].blank?
        permitted_params.delete(:password)
        permitted_params.delete(:password_confirmation)
      end

      permitted_params
    end
end
