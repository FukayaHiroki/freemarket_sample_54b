class ChangePhoneToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :phone, null: true
  end
end
