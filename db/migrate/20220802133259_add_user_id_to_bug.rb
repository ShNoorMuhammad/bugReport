class AddUserIdToBug < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :user_id, :integer
  end
end
