class AddSizeIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :size_id, :integer
  end
end
