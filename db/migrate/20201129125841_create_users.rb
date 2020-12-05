# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest
      t.boolean :is_admin, default: false, null: false
      t.datetime :remember_token

      t.timestamps
    end
  end
end
