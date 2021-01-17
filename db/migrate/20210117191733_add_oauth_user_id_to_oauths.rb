class AddOauthUserIdToOauths < ActiveRecord::Migration[6.0]
  def change
    add_column :oauths, :oauth_user_id, :string
  end
end
