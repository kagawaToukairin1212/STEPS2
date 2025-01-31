class CreateQuestionResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :question_responses do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
