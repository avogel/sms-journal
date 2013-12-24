class AddIndexForPhone < ActiveRecord::Migration
  def change
        add_index :users, :phone_number
  end
end
