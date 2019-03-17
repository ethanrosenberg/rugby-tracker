class Helpers

  def self.current_user(session)
     @user = User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    session[:user_id] ? true : false
  end

  def self.redirect_if_not_logged_in
      if !is_logged_in?
        redirect "/sessions/login?error=You have to be logged in to do that..."
      end
  end

end
