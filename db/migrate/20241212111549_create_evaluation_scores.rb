class CreateEvaluationScores < ActiveRecord::Migration[7.2]
  def change
    create_table :evaluation_scores do |t|
      t.references :goal, null: false, foreign_key: true # Goalに関連付ける
      t.integer :result, null: false # 評価スコア（必須）

      t.timestamps
    end
  end
end
