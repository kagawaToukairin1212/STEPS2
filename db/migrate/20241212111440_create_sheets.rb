class CreateSheets < ActiveRecord::Migration[7.2]
  def change
    create_table :sheets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
