# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :tags, array: true, index: true, default: []
      t.integer :answer_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
