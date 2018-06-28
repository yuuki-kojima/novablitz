class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image
      t.integer :category
      t.text :text
      t.timestamps
    end
  end
end
