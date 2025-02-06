class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
    
      respond_to do |format|
        if @user.save
          # ユーザーが保存されたことを確認
          if @user.persisted?
            begin
              UserMailer.with(user: @user).welcome_email.deliver_now # テスト用に変更
            rescue => e
              Rails.logger.error "UserMailer failed: #{e.message}"
            end
          end
    
          format.html { redirect_to root_path, notice: "ユーザーが正常に作成されました" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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
