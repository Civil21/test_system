class AddTimeSizeToSubject < ActiveRecord::Migration[6.0]
  def change
    add_column :subjects, :time_size, :integer
  end
end
