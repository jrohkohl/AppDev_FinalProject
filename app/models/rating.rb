# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  comment       :text
#  rating        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#  user_id       :integer
#

class Rating < ApplicationRecord

  belongs_to :user
  belongs_to :restaurant

  validates :user_id, :presence => true
  validates :restaurant_id, :presence => true
  validates :rating, :presence => true
end
