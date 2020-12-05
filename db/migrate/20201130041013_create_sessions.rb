# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :token, null: false

      t.timestamps
    end
  end
end
