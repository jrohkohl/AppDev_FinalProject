# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  tag           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#  user_id       :integer
#

class Tag < ApplicationRecord

  belongs_to :user
  belongs_to :restaurant

  validates :user_id, :presence => true
  validates :restaurant_id, :presence => true
end
