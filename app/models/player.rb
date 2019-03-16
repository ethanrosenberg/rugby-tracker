class Player < ActiveRecord::Base
  #player belongs to User (coach)
  belongs_to :user

  def self.valid_params?(params)
   return !params[:name].empty? && !params[:position].empty?
  end

end
