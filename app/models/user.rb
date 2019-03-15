class User < ActiveRecord::Base
  #user (coach) has many players
  has_many :players

end