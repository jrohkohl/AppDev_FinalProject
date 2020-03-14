# == Schema Information
#
# Table name: statistics
#
#  id             :integer          not null, primary key
#  average_rating :float
#  count_ratings  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  restaurant_id  :integer
#

class Statistic < ApplicationRecord

  belongs_to :restaurant
end
