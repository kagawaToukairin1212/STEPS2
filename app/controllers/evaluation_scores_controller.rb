class EvaluationScoresController < ApplicationController
  before_action :set_sheet, only: [:new, :create, :index, :edit_by_date, :update_by_date]

  def new
    @goals = @sheet.goals
    @evaluation_scores = @goals.map { |goal| goal.evaluation_scores.build }
  end

  def create
    EvaluationScore.transaction do
      common_time = Time.current
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

  def edit_by_date
    # デバッグ出力
    puts "DEBUG: sheet_id = #{params[:sheet_id]}"
    @sheet = Sheet.find_by(id: params[:sheet_id])
    unless @sheet
      redirect_to sheets_path, alert: "シートが見つかりません。" and return
    end

    date = params[:date]
    begin
      @date_formatted = DateTime.parse(date).strftime("%Y/%m/%d %H:%M")
    rescue ArgumentError
      redirect_to sheet_path(@sheet), alert: "無効な日付フォーマットです。" and return
    end

    @evaluation_scores = @sheet.goals.includes(:evaluation_scores)
                              .flat_map(&:evaluation_scores)
                              .compact
                              .select { |s| s.created_at&.strftime("%Y/%m/%d %H:%M:%S") == date }

    if @evaluation_scores.empty?
      redirect_to sheet_path(@sheet), alert: "指定された日付の評価結果が見つかりません。" and return
    end
  end

  def update_by_date
    @sheet = Sheet.find_by(id: params[:sheet_id])
    unless @sheet
      redirect_to sheets_path, alert: "シートが見つかりません。" and return
    end

    params[:evaluation_scores].each do |id, result|
      score = EvaluationScore.find_by(id: id)
      score.update(result: result) if score.present?
    end

    redirect_to sheet_path(@sheet), success: "評価結果を更新しました。"
  end

  def destroy_by_date
    @sheet = Sheet.find(params[:sheet_id])
    date_str = params[:date]
  
    begin
      datetime = DateTime.parse(date_str)
    rescue ArgumentError
      redirect_to sheet_path(@sheet), alert: "無効な日付です。" and return
    end
  
    scores = EvaluationScore.joins(:goal).where(goals: { sheet_id: @sheet.id })
                            .where("evaluation_scores.created_at BETWEEN ? AND ?", datetime.beginning_of_minute, datetime.end_of_minute)
  
    if scores.any?
      scores.destroy_all
      redirect_to sheet_path(@sheet), notice: "評価結果を削除しました。"
    else
      redirect_to sheet_path(@sheet), alert: "該当する評価結果が見つかりませんでした。"
    end
  end

  private

  def set_sheet
    @sheet = current_user.sheets.find_by(id: params[:sheet_id])
  end
end
