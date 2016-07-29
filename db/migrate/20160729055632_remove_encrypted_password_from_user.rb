class RemoveEncryptedPasswordFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :encrypted_password, :string
  end
end
