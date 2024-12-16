class EvaluationScoresController < ApplicationController
  before_action :set_sheet, only: [ :new, :create, :index ]

  def new
    @goals = @sheet.goals
    @evaluation_scores = @goals.map { |goal| goal.evaluation_scores.build }
  end

  def create
    EvaluationScore.transaction do
      @evaluation_scores = params[:scores].map do |score_params|
        @sheet.goals.find(score_params[:goal_id]) # goalがこのsheetに属するか確認
        EvaluationScore.create!(score_params.permit(:goal_id, :result))
      end
    end
    redirect_to mypage_path, notice: "結果が保存されました！"
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    flash.now[:alert] = "エラーが発生しました: #{e.message}"
    render :new
  end


  def index
    @sheet = Sheet.find(params[:sheet_id])
    @goals = @sheet.goals
    @evaluation_scores = EvaluationScore.where(goal: @goals) # @goalsに関連するスコアを取得
  end

  private

  def set_sheet
    @sheet = current_user.sheets.find(params[:sheet_id])
  end
end
