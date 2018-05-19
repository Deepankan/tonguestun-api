class CreateAccessTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :access_tokens do |t|
      t.references  :user, index: true, foreign_key: true
      t.string :access_token
      t.timestamps
    end
  end
end
