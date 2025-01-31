module UsersHelper
  # レーダーグラフ用データ (過去と最新のスコア)
  def radar_chart_data_with_history(sheet)
    data_sets = []

    # 最新データ
    latest_data = {}
    sheet.goals.each do |goal|
      label = goal.evaluation_department.name
      latest_data[label] = goal.evaluation_scores.pluck(:result).last || 0
    end
    data_sets << { name: "最新結果", data: latest_data }

    # 過去データ
    previous_data = {}
    sheet.goals.each do |goal|
      label = goal.evaluation_department.name
      previous_data[label] = goal.evaluation_scores.pluck(:result).second_to_last || 0
    end
    data_sets << { name: "過去結果", data: previous_data }

    data_sets
  end
end
