class RemoveImageIdFromProducts < ActiveRecord::Migration[5.2]
  def change
    def up
      remove_column :products, :image_id
    end

    def dowm
      add_column :products, :image_id, :references, foreign_key: true
    end
  end
end
