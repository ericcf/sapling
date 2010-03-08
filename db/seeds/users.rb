# administrator

admin_role = Role.find_by_name('Admin')

admin_user = User.create!(:username => 'admin',
  :password => 'admin',
  :password_confirmation => 'admin')

RoleAssignment.create!(:role => admin_role, :entity => admin_user)


# anonymous

anonymous_role = Role.find_by_name('Anonymous')

RoleAssignment.create!(:role => anonymous_role, :entity => nil)