# frozen_string_literal: true

class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.integer :user_id, null: false
      t.integer :subject_id, null: false
      t.integer :point, default: 0, null: false
      t.datetime :start_at
      t.datetime :finish_at
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
