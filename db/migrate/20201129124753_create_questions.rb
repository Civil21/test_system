class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :subject_id
      t.string :name
      t.integer :point

      t.timestamps
    end
  end
end
