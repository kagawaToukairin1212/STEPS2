class SheetsController < ApplicationController
  before_action :set_sheet, only: %i[show edit_goals update_goals destroy]

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

    # 評価結果を表形式で取得する
    @evaluation_results = []
    @sheet.goals.each do |goal|
      row = { name: goal.evaluation_department.name } # 目標の名前（例: "リズム能力"）
      @scores_by_date.each do |date, scores|
        score = scores.find { |s| s.goal_id == goal.id }
        row[date] = score ? score.result : "-" # 結果がない場合は "-"
      end
      @evaluation_results << row
    end
  end

  def destroy
    @sheet.destroy
    redirect_to mypage_path, notice: "シートが削除されました。"
  end
  

  def edit_goals
    @goals = @sheet.goals  # 既存の目標を取得
  end

  def update_goals
    if @sheet.update(sheet_params)
      redirect_to @sheet, success: "目標を更新しました。"
    else
      flash.now[:danger] = "目標の更新に失敗しました。"
      render :edit_goals, status: :unprocessable_entity
    end
  end

  private

  def sheet_params
    params.require(:sheet).permit(:title, goals_attributes: [ :id, :value ])
  end

  def set_sheet
    @sheet = Sheet.find_by(id: params[:id])
  end

  def sheet_goal_params
    params.require(:sheet).permit(goals_attributes: [ :id, :value ])
  end
end
