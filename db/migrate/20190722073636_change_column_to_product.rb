class ChangeColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :products, :price, :integer, null: false, default: 0
      change_column :products, :prefecture_id, :integer, null: false, default: 0
    end

    def down
      change_column :products, :price, :integer, null: true, default: 0
      change_column :products, :prefecture_id, :integer, null: true, default: 0
    end
  end
end
