class User < ApplicationRecord
  belongs_to :organization, optional: true
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
class << self
  def from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    user.save!
    user
  end
end
end
