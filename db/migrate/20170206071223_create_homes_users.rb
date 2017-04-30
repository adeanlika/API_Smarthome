class CreateHomesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :homes_users do |t|
      t.integer :home_id
      t.integer :user_id

      t.timestamps
    end
  end
end
