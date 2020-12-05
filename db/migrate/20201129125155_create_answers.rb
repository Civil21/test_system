# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.integer :variant_id
      t.boolean :correct, default: false, null: false
      t.integer :attempt_id, null: false

      t.timestamps
    end
  end
end
