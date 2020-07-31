class CreateDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_addresses do |t|
      t.string :delivery_family_name,       null: false
      t.string :delivery_first_name,        null: false
      t.string :delivery_family_name_kana,  null: false
      t.string :delivery_first_name_kana,   null: false
      t.integer :post_code,                 null: false
      t.integer :prefecture_id,             null: false
      t.string :city,                       null: false
      t.string :home_number,                null: false
      t.string :building_name
      t.integer :phone_number,              unique: true
      t.references :user,                null: false, foreign_key: true
      t.timestamps
    end
  end
end
