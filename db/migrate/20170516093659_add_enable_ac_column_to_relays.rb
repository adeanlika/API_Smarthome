class AddEnableAcColumnToRelays < ActiveRecord::Migration[5.0]
  def change
    add_column :relays, :ac_state, :string
  end
end
