class AddUserInfo < ActiveRecord::Migration
  def change
        add_column :users, :email, :string
        add_column :users, :password_digest, :string
        add_column :users, :remember_token, :string
        add_column :users, :phone_number, :string

        add_index :users, :remember_token
        add_index :users, :email
  end
end
