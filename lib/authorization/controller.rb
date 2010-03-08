module Authorization

  module Controller

    def check_authorization(user, action, state=nil)
      unless user.is_authorized?(controller_name, action, state)
        @content_partial = 'shared/site/unauthorized'
        render :template => 'shared/site/minimal_view'
        return false
      end
    end
  end
end