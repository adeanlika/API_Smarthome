class AddDefRefToMotions < ActiveRecord::Migration[5.0]
  def change
    add_reference :motions, :device, foreign_key: true
  end
end
