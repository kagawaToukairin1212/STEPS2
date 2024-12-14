class CreateEvaluationDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :evaluation_departments do |t|
      t.string :name, null: false
      t.boolean :default, default: false, null: false

      t.timestamps
    end
  end
end
