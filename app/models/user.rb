class User < ActiveRecord::Base
  before_create :lower_case_email

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :location, :state, presence: true
  validates :password, length: { minimum: 8 }, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  has_many :events
  has_many :comments
  has_many :attendees, dependent: :destroy
  has_many :attending, through: :attendees, source: :event
  has_secure_password

  private
    def lower_case_email
      self.email.downcase!
    end
end
