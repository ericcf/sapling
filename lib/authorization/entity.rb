module Authorization

  module Entity

    def is_authorized?(controller_name, action_name, state_name=nil)
      role = self.roles.detect { |role|
        role.rights(state_name).detect { |right|
          right.controller == controller_name && right.action == action_name
        }
      }
      !role.nil?
    end
  end
end