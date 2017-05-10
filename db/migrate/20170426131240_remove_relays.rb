class RemoveRelays < ActiveRecord::Migration[5.0]
  def change
    drop_table :relays
  end
end
