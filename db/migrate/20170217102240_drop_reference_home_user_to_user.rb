class DropReferenceHomeUserToUser < ActiveRecord::Migration[5.0]
  def change
    remove_reference :homes_users, :users
  end
end
