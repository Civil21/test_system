# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.integer :question_id, null: false
      t.string :name, null: false
      t.boolean :correct, default: false, null: false

      t.timestamps
    end
  end
end
