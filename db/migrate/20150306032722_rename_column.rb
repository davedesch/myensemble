class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :favorites, :type, :fave_type
  end
end
