class ChangePostalcodeToAdress < ActiveRecord::Migration[5.2]
  def change
    change_column :adresses, :postal_code, :string
  end
end
