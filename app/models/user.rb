class User < ActiveRecord::Base

  has_secure_password
  #user (coach) has many players
  has_many :players

end
