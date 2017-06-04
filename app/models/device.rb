# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  name       :string
#  productID  :string
#  img        :binary
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  home_id    :integer
#

class Device < ApplicationRecord
mount_uploader :picture, AvatarUploader
belongs_to :home
has_one :relay, dependent: :destroy
has_many :humidities, dependent: :destroy
has_many :temperatures, dependent: :destroy
has_many :motions, dependent: :destroy
has_many :carbondioxides, dependent: :destroy
has_many :lights, dependent: :destroy
accepts_nested_attributes_for :temperatures, :humidities, :carbondioxides, :motions, :lights, :home

end
