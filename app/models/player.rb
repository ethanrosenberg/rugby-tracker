class Player < ActiveRecord::Base
  #player belongs to User (coach)
  belongs_to :user
end