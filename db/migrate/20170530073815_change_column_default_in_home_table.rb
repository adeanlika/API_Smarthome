class ChangeColumnDefaultInHomeTable < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:homes, :lowertemp, 0)
    change_column_default(:homes, :uppertemp, 1000000)
    change_column_default(:homes, :lowerhum, 0)
    change_column_default(:homes, :upperhum, 1000000)
    change_column_default(:homes, :lowerco, 0)
    change_column_default(:homes, :upperco, 1000000)
    change_column_default(:homes, :lowerflux, 0)
    change_column_default(:homes, :upperflux, 1000000)
    change_column_default(:homes, :upperenergy, 1000000)
    change_column_default(:homes, :cost_limit, 1000000)
    change_column_default(:homes, :lowertemp_flag, false)
    change_column_default(:homes, :uppertemp_flag, false)
    change_column_default(:homes, :lowerhum_flag, false)
    change_column_default(:homes, :upperhum_flag, false)
    change_column_default(:homes, :lowerco_flag, false)
    change_column_default(:homes, :upperco_flag, false)
    change_column_default(:homes, :upperenergy_flag, false)
    change_column_default(:homes, :lowerflux_flag, false)
    change_column_default(:homes, :upperflux_flag, false)
    change_column_default(:homes, :cost_limit_flag, false)

  end
end
