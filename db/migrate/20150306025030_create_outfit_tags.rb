class CreateOutfitTags < ActiveRecord::Migration
  def change
    create_table :outfit_tags do |t|
      t.integer :outfit_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
