class RenameColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :slug, :friendly_id_slugs
  end
end
