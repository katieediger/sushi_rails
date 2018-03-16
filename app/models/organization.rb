class Organization < ApplicationRecord
  has_many :data
  has_many :users
  has_many :sushis 
end
