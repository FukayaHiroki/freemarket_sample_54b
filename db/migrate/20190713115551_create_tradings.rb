class CreateTradings < ActiveRecord::Migration[5.2]
  def change
    create_table :tradings do |t|
      t.integer :status, null: false
      t.references :products, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
