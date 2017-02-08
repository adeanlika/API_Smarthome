class CreateRelays < ActiveRecord::Migration[5.0]
  def change
    create_table :relays do |t|
    	t.binary :relay1, :limit => 1, :default => 0
    	t.binary :relay2, :limit => 1, :default => 0
    	t.binary :relay3, :limit => 1, :default => 0
    	t.binary :relay4, :limit => 1, :default => 0
    	t.binary :relay5, :limit => 1, :default => 0
    	t.binary :relay6, :limit => 1, :default => 0
    	t.binary :relay7, :limit => 1, :default => 0
    	t.binary :relay8, :limit => 1, :default => 0
    	
    	t.string :relay1name
    	t.string :relay2name
    	t.string :relay3name
    	t.string :relay4name
    	t.string :relay5name
    	t.string :relay6name
    	t.string :relay7name
    	t.string :relay8name
    	
    	t.string :acname
    	t.binary :acmode, :limit => 4, :default => 0000
    	t.binary :acstate, :limit => 4, :default => 0000
    	t.binary :acspeed, :limit => 4, :default => 0000
    	t.binary :acdirection, :limit => 4, :default => 0000

      t.timestamps
    end
  end
end
