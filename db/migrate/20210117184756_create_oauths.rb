class CreateOauths < ActiveRecord::Migration[6.0]
  def change
    create_table :oauths do |t|
      t.string :oauth_token
      t.string :oauth_token_secret
      t.string :screen_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
