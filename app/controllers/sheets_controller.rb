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
      redirect_to mypage_path, notice: "シートが作成されました"
    else
      flash.now[:alert] = "シートの作成に失敗しました"
      render :new
    end
  end

  def show
    @sheet = Sheet.find(params[:id])
  end

  private

  def sheet_params
    params.require(:sheet).permit(:title)
  end
end