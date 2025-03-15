module SheetsHelper
  def radar_chart_data_with_history(sheet)
    data_sets = []
    # 目標の数だけ履歴の長さをチェック（最長の履歴数）
    history_size = sheet.goals.map { |goal| goal.evaluation_scores.size }.max

    history_size.times do |index|
      history_data = {}
      sheet.goals.each do |goal|
        label = goal.evaluation_department.name
        # 古い順でindex番目の結果を取得（なければ0）
        history_data[label] = goal.evaluation_scores.order(:created_at).pluck(:result)[index] || 0
      end

      data_sets << {
        name: "#{index + 1}回目",
        data: history_data
      }
    end

    data_sets
  end
end
