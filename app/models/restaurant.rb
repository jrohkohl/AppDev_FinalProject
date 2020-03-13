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

  validates :name, :presence => true
end
