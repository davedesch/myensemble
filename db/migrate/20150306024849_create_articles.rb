class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :outfit_id
      t.integer :article_type_id
      t.string :brand
      t.string :url
      t.boolean :discontinued, :default => false
      t.boolean :vintage, :default => false

      t.timestamps
    end
  end
end
