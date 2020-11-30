class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.integer :question_id
      t.string :name
      t.boolean :correct

      t.timestamps
    end
  end
end
