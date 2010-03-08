module SaplingUser

  def current_user
    User.find_by_id(session[:user]) || AnonymousUser.new
  end
end