class CreateMoves < ActiveRecord::Migration[7.1]
  def change
    create_table :moves do |t|
      t.integer :accuracy
      t.string :ename
      t.integer :power
      t.integer :pp
      t.string :type

      t.timestamps
    end
  end
end
