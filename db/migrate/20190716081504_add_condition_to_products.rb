class AddConditionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :condition_id, :integer, null: false
  end
end
