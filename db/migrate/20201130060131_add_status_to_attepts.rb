# frozen_string_literal: true

class AddStatusToAttmepts < ActiveRecord::Migration[6.0]
  def change
    add_column :attempts, :status, :integer
  end
end
