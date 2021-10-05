class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.references :brand, foreign_key: true
      t.string :pack_size
      t.float :price
      t.text :body
      t.string :productimages

      t.timestamps
    end
  end
end
