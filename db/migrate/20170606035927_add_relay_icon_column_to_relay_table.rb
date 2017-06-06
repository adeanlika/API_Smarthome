class AddRelayIconColumnToRelayTable < ActiveRecord::Migration[5.0]
  def change
    add_column :relays, :relay1icon, :integer, :default => 0
    add_column :relays, :relay2icon, :integer, :default => 0
    add_column :relays, :relay3icon, :integer, :default => 0
    add_column :relays, :relay4icon, :integer, :default => 0
    add_column :relays, :relay5icon, :integer, :default => 0
    add_column :relays, :relay6icon, :integer, :default => 0
    add_column :relays, :relay7icon, :integer, :default => 0
    add_column :relays, :relay8icon, :integer, :default => 0
  end
end
