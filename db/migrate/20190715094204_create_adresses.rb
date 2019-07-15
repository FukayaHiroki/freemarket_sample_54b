class CreateAdresses < ActiveRecord::Migration[5.2]
  def change
    create_table :adresses do |t|
      t.string     :family_name,        null: false
      t.string     :first_name,         null: false
      t.string     :family_name_kana,   null: false
      t.string     :first_name_kana,    null: false
      t.integer    :postal_code,        null: false
      t.integer    :prefecture_id,      null: false
      t.string     :city,               null: false
      t.string     :block,              null: false
      t.string     :building,           null: true
      t.string     :sub_phone,          null: true
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
