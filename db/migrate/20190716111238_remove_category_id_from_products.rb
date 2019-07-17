class RemoveCategoryIdFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :products, :large_category_id
  end
end
