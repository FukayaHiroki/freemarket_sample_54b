class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :products, :user_id, :references, null: true
    end

    def down
      change_column :products, :user_id, :references, null: false
    end
  end
end
