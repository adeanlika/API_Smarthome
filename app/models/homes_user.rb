# == Schema Information
#
# Table name: homes_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  home_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HomesUser < ApplicationRecord
  belongs_to :user
  belongs_to :home
end
