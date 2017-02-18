class DropReferenceHomeUserToUser < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :homes_users
  end
end
