class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :image_url
      t.integer :user_id
      t.string :title
      t.text :caption
      t.string :gender

      t.timestamps
    end
  end
end
