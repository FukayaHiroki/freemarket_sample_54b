class ChangePhoneToUser2 < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :phone, null: false
  end
end
