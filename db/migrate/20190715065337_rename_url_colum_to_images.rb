class RenameUrlColumToImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :URL, :url
  end
end
