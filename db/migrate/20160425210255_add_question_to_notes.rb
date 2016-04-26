class AddQuestionToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :qsix, :string
    add_column :notes, :qseven, :string
    add_column :notes, :asix, :text
    add_column :notes, :aseven, :text
    add_column :notes, :pasix, :text
    add_column :notes, :paseven, :text
  end
end
