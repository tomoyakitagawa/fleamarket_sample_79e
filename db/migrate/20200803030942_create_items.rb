class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :explanation, null: false
      t.references :category, foreign_key: true
      t.string :brand
      t.integer :condition_id, null: false
      t.integer :postage_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :prepare_id, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
