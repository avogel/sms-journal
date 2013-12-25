class AddDateToEntry < ActiveRecord::Migration
  def change
        add_column :entries, :submit_date, :date
  end
end
