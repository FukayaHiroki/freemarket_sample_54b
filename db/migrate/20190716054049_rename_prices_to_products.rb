class RenamePricesToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :prefecture_id, :integer, null: false
  end
end
