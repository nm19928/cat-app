class AddOwnerId < ActiveRecord::Migration[6.0]
  def change
    add_column :cats, :owner_id, :string, null:false
    add_index :cats, :owner_id
  end
end
