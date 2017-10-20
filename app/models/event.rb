class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees

  validates :name, :location, :state, presence: true
  validates :date, inclusion: {in: (Date.tomorrow..Float::INFINITY) }
end
