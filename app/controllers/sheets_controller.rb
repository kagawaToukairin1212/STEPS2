class SheetsController < ApplicationController
  def new
    @sheet = Sheet.new
    @evaluation_departments = EvaluationDepartment.where(default: true) # 初期項目のみ取得
  end

  def create
    @sheet = current_user.sheets.new(sheet_params)
    if @sheet.save
      params[:evaluation_items].each do |item|
        @sheet.goals.create(
          evaluation_department_id: item[:evaluation_department_id],
          value: item[:goal]
        )
      end
      redirect_to mypage_path, success: t("sheet.new.success")
    else
      flash.now[:danger] = t("sheet.new.failure")
      render :new
    end
  end


  def show
    @sheet = Sheet.find(params[:id])

    @sheets = current_user.sheets.includes(goals: :evaluation_scores)

      # レーダーグラフ用データを生成
      @radar_chart_data = @sheets.map do |sheet|
        {
          title: sheet.title,
          date: sheet.created_at.strftime('%Y/%m/%d'), # or 最新スコア日付
          labels: sheet.goals.map { |goal| goal.evaluation_department.name },
          latestResults: sheet.goals.map { |goal| goal.evaluation_scores.last&.result || 0 },
          previousResults: sheet.goals.map { |goal| goal.evaluation_scores.second_to_last&.result || 0 },
          goals: sheet.goals.map { |goal| goal.value }
        }
      end



    # 評価項目のラベル
    @labels = EvaluationDepartment.pluck(:name)

  # シートに紐づく評価結果を日付ごとに取得
    @scores_by_date = @sheet.goals.flat_map(&:evaluation_scores)
                             .group_by { |s| s.created_at.strftime("%Y/%m/%d %H:%M:%S") }

    @scores = @scores_by_date.map do |date, scores|
      {
        date: date,
        values: scores.map(&:result)
      }
    end

    # 色の配列をビューに渡す
    @colors = [
      "rgba(255, 99, 132, 0.5)",  # 赤
      "rgba(255, 159, 64, 0.5)",   # 橙
      "rgba(255, 205, 86, 0.5)",   # 黄
      "rgba(75, 192, 192, 0.5)",   # 緑
      "rgba(54, 162, 235, 0.5)",   # 青
      "rgba(104, 132, 245, 0.5)",  # 藍
      "rgba(153, 102, 255, 0.5)"   # 紫
    ]
  end

  private

  def sheet_params
    params.require(:sheet).permit(:title)
  end
end

