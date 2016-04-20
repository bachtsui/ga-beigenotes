class CreateUserContactJoints < ActiveRecord::Migration
  def change
    create_table :user_contact_joints do |t|

      t.timestamps null: false

      t.references :user
      t.references :contact 
    end
  end
end
