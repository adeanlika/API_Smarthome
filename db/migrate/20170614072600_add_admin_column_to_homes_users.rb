class AddAdminColumnToHomesUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :homes_users, :is_admin, :boolean, :default => false

  end
end
