# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  email      :string
#  password   :string
#  avatar     :binary
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
has_and_belongs_to_many :homes
end
