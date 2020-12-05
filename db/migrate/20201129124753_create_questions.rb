# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :subject_id, null: false
      t.string :name, null: false
      t.integer :point, default: 1, null: false
      t.integer :recomend, default: 1, null: false

      t.timestamps
    end
  end
end
