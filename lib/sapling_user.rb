module SaplingUser

  def current_user
    User.find_by_id(session[:user]) || AnonymousUser.new
  end

  def current_user_id
    session[:user]
  end
end