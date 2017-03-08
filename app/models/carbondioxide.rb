class Carbondioxide < ApplicationRecord
  has_many :co_alert_logs
  belongs_to :device
end
