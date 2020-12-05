# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :name, null: false
      t.string :desc
      t.integer :questions_size
      t.integer :time_size, default: 15, null: false

      t.timestamps
    end
  end
end
