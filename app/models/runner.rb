class Runner < ActiveRecord::Base
  has_many :workouts

  has_secure_password
  validates :email, uniqueness: true
  validates :name, :email, :password, presence: true

end
