module SheetsHelper
  # レーダーグラフ用データ (過去と最新のスコア)
  def radar_chart_data_with_history(sheet)
    data_sets = []

    # 各スコアの履歴数を取得（例えば7件まで）
    history_size = sheet.goals.first.evaluation_scores.size

    history_size.times do |index|
      history_data = {}
      sheet.goals.each do |goal|
        label = goal.evaluation_department.name
        history_data[label] = goal.evaluation_scores.pluck(:result).reverse[index] || 0
      end

      data_sets << { 
        name: "#{index + 1}回前", 
        data: history_data 
      }
    end

    data_sets
  end
end
