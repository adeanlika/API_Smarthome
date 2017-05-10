class AddGatewayToHomeTable < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :gateway_id, :string
  end
end
