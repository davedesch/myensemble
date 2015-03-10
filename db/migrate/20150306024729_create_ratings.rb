class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :outfit_id
      t.text :comment
      t.integer :stars

      t.timestamps
    end
  end
end
