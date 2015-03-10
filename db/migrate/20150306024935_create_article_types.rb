class CreateArticleTypes < ActiveRecord::Migration
  def change
    create_table :article_types do |t|
      t.string :type_desc

      t.timestamps
    end
  end
end
