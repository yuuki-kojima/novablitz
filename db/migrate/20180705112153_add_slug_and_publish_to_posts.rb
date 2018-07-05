class AddSlugAndPublishToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :slug, :string
    add_column :posts, :publish, :boolean
    add_index :posts, :slug
  end
end
