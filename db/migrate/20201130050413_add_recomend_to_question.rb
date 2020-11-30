class AddRecomendToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :recomend, :integer
  end
end
