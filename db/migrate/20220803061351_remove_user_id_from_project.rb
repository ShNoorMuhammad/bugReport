class RemoveUserIdFromProject < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :user_id
    remove_column :projects, :bug_id
  end
end
