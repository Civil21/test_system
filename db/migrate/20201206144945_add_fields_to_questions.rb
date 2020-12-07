class AddFieldsToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :correct_answers, :integer
    add_column :questions, :answers_count, :integer
  end
end
