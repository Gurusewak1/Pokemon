class RenameTypeColumnInMoves < ActiveRecord::Migration[6.1]
  def change
    rename_column :moves, :type, :move_type
  end
end
