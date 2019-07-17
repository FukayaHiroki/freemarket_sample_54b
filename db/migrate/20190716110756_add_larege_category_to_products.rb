class AddLaregeCategoryToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :large_category
  end
end
