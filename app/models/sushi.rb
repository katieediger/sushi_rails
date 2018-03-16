class Sushi < ApplicationRecord
  belongs_to :organization
  validates_uniqueness_of :name, scope: :user_id
  validates :name, presence: true
  validates :endpoint, presence: true
  validates :cust_id, presence: true
  validates :report_start, presence: true
  validates :report_end, presence: true
  validates_format_of :report_start, :with => /\d{4}-\d{2}-\d{2}/, :message => "^Date must be in the following format: YYYY-MM-DD"
  validates_format_of :report_end, :with => /\d{4}-\d{2}-\d{2}/, :message => "^Date must be in the following format: YYYY-MM-DD"
end
