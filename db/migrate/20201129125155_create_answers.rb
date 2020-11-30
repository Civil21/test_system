# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :variant_id
      t.boolean :correct
      t.integer :attempt_id

      t.timestamps
    end
  end
end
