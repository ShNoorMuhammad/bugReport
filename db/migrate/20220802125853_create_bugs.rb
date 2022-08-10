class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.text :description
      t.string :bug_title      
      t.date :deadline
      t.string :status
      t.string :type
      t.string :image
      

      t.timestamps
    end
  end
end
