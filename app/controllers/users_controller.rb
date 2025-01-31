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
      # シートに紐づく評価スコアを取得
      @sheets = current_user.sheets.includes(goals: :evaluation_scores)

      # レーダーグラフ用データを生成
      @radar_chart_data = @sheets.map do |sheet|
        {
          title: sheet.title,
          labels: sheet.goals.map { |goal| goal.evaluation_department.name },
          latestResults: sheet.goals.map { |goal| goal.evaluation_scores.pluck(:result).last || 0 },
          previousResults: sheet.goals.map { |goal| goal.evaluation_scores.pluck(:result).second_to_last || 0 }
        }
      end
    end

    def profile
      @user = current_user # ログイン中のユーザー情報を取得
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
