class PasswordResetsController < ApplicationController
    skip_before_action :require_login
  
    def new
    end
  
    def create
      @user = User.find_by(email: params[:email])
  
      if @user
        @user.deliver_reset_password_instructions!
      end
  
      flash[:success] = "パスワードリセット手順を送信しました"
      redirect_to login_path
    end
  
    def edit
      @user = User.load_from_reset_password_token(params[:id])
      return not_authenticated unless @user
    end
  
    def update
        @user = User.load_from_reset_password_token(params[:id])
        return not_authenticated unless @user
      
        # パスワードと確認用が一致しているか確認
        if params[:password] != params[:password_confirmation]
          flash[:error] = "パスワード確認が一致しません"
          render :edit and return
        end
      
        # Sorceryのパスワード変更メソッドを実行
        if @user.change_password(params[:password])
          flash[:success] = "パスワードを変更しました"
          redirect_to login_path, status: :see_other
        else
          # エラーメッセージをログに出力
          Rails.logger.info "パスワード変更エラー: #{@user.errors.full_messages.join(", ")}"
          flash[:error] = @user.errors.full_messages.join(", ")
          render :edit, status: :unprocessable_entity
        end
    end
      
end
  