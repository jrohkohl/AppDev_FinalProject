# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  ratings_count   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many :ratings, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  has_many :rated_restaurants, :through => :ratings, :source => :restaurant
  has_many :restaurants, :through => :tags, :source => :restaurant
end
