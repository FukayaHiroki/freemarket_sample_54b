class RemoveLargeCategoryIdFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :products, :large_category
  end
end
