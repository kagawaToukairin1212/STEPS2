class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject
      t.text :content
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
