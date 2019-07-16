class AddShippingToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :shipping_speed_id, :integer, null: false
    add_column :products, :shipping_method_id, :integer, null:false
  end
end
