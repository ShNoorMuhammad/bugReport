class RemoveAddnameField < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :AddNameToUser
  end
end
