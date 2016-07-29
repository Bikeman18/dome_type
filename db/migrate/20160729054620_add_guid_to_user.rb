class AddGuidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :guid, :integer
  end
end
