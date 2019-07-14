class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :detail, null:false
      t.references :user, foreign_key: true
      t.references :image, foreign_key: true
      t.timestamps
    end

    add_index :products, :name
  end
end

