class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :fave_id
      t.string :type

      t.timestamps
    end
  end
end
