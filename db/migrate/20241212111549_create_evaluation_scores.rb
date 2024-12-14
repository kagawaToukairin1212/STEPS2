class CreateEvaluationScores < ActiveRecord::Migration[7.2]
  def change
    create_table :evaluation_scores do |t|
      t.references :sheet, null: false, foreign_key: true
      t.references :evaluation_department, null: false, foreign_key: true
      t.integer :result

      t.timestamps
    end
  end
end
