class AddPanswerToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :panswer, :text
  end
end
