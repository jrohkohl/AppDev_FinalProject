# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  address    :string
#  category   :string
#  image      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Restaurant < ApplicationRecord

  has_many :ratings, :dependent => :destroy
  has_many :tags, :dependent => :destroy

  has_many :users_who_rated, :through => :ratings, :source => :user
  has_many :users, :through => :tags, :source => :user
  has_one :statistic, :dependent => :destroy

  validates :name, :presence => true

  def in_db

    all_rest_names = Restaurant.where({:name => self.name })

    rest_address_match = all_rest_names.where({:address => self.address}).at(0)

    return rest_address_match

  end 

end
