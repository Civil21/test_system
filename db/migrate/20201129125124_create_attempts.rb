class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :point
      t.datetime :start_at
      t.datetime :finish_at

      t.timestamps
    end
  end
end
