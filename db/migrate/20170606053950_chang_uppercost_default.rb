class ChangUppercostDefault < ActiveRecord::Migration[5.0]
  def change

    change_column_default(:homes, :uppertemp, 10000000)
    change_column_default(:homes, :upperhum, 10000000)
    change_column_default(:homes, :upperco, 10000000)
    change_column_default(:homes, :upperflux, 10000000)
    change_column_default(:homes, :upperenergy, 100000000)
    change_column_default(:homes, :cost_limit, 100000000)
  end
end
