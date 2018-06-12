class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string  :name,     null: false, index: true, unique: true
      t.string  :set,      null: false
      t.string  :type,     null: false
      t.string  :sub_type
      t.string  :aspect,   null: false
      t.string  :rarity,   null: false
      t.integer :cost,     null: false
      t.integer :attack
      t.integer :health
      t.text    :image,    null: false, unique: true
      t.text    :content
      t.text    :content_jp
      t.timestamps
    end
  end
end
