class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.string :instagram_name
      t.string :auth_token

      t.timestamps
    end
  end
end
