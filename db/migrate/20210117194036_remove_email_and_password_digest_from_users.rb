class RemoveEmailAndPasswordDigestFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :password_digest
    remove_column :users, :email
  end
end
