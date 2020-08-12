class Records < ActiveRecord::Migration[6.0]
  def down
    drop_table :details
  end
end
