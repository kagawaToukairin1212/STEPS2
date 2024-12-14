class CreateGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :goals do |t|
      t.references :sheet, null: false, foreign_key: true
      t.references :evaluation_department, null: false, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
