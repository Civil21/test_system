# frozen_string_literal: true

class AddStatusToAttempts < ActiveRecord::Migration[6.0]
  def change
    add_column :attempts, :status, :integer
  end
end
