class AddColumnToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :qone, :string
    add_column :notes, :qtwo, :string
    add_column :notes, :qthree, :string
    add_column :notes, :qfour, :string
    add_column :notes, :qfive, :string
    add_column :notes, :aone, :text
    add_column :notes, :atwo, :text
    add_column :notes, :athree, :text
    add_column :notes, :afour, :text
    add_column :notes, :afive, :text
    add_column :notes, :paone, :text
    add_column :notes, :patwo, :text
    add_column :notes, :pathree, :text
    add_column :notes, :pafour, :text
    add_column :notes, :pafive, :text
  end
end
