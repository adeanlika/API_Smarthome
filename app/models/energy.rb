# == Schema Information
#
# Table name: energies
#
#  id         :integer          not null, primary key
#  power      :float
#  Etotal     :float
#  Eday       :float
#  Emonth     :float
#  Eyear      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  home_id    :integer
#
class Energy < ApplicationRecord
	belongs_to :home
end
