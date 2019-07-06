class AddTextPathToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :text_path, :string
  end
end
