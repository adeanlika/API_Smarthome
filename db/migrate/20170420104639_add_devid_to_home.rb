class AddDevidToHome < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :devid, :string
  end
end
