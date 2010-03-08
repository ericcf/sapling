# permissions

view_permission = Right.create!(
  :name => 'view content',
  :controller => 'nodes',
  :action => 'show'
)
new_permission = Right.create!(
  :name => 'make new content',
  :controller => 'nodes',
  :action => 'new'
)
create_permission = Right.create!(
  :name => 'save new content',
  :controller => 'nodes',
  :action => 'create'
)
edit_permission = Right.create!(
  :name => 'edit existing content',
  :controller => 'nodes',
  :action => 'edit'
)
update_permission = Right.create!(
  :name => 'modify existing content',
  :controller => 'nodes',
  :action => 'update'
)
destroy_permission = Right.create!(
  :name => 'delete existing content',
  :controller => 'nodes',
  :action => 'destroy'
)
workflow_permission = Right.create!(
  :name => 'change workflow state',
  :controller => 'workflow',
  :action => 'update_state'
)
section_index_permission = Right.create!(
  :name => 'view sections',
  :controller => 'sections',
  :action => 'index'
)
section_view_permission = Right.create!(
  :name => 'view section',
  :controller => 'sections',
  :action => 'show'
)
admin_index_view_permission = Right.create!(
  :name => 'view admin index',
  :controller => 'admin',
  :action => 'index'
)
# admin/users_controller permissions
users_index_permission = Right.create!(
  :name => 'view users index',
  :controller => 'users',
  :action => 'index'
)
users_show_permission = Right.create!(
  :name => 'view user',
  :controller => 'users',
  :action => 'show'
)
users_new_permission = Right.create!(
  :name => 'make new user',
  :controller => 'users',
  :action => 'new'
)
users_create_permission = Right.create!(
  :name => 'save new user',
  :controller => 'users',
  :action => 'create'
)
users_edit_permission = Right.create!(
  :name => 'edit user',
  :controller => 'users',
  :action => 'edit'
)
users_update_permission = Right.create!(
  :name => 'save edited user',
  :controller => 'users',
  :action => 'update'
)
users_destroy_permission = Right.create!(
  :name => 'delete user',
  :controller => 'users',
  :action => 'destroy'
)

# states

private_state = WorkflowState.find_by_name('private')
public_state = WorkflowState.find_by_name('public')

# roles

admin_role = Role.create!(:name => 'Admin')

# view content
StatefulRight.create!(
  :right => view_permission,
  :role => admin_role,
  :workflow_state => private_state
)
StatefulRight.create!(
  :right => view_permission,
  :role => admin_role,
  :workflow_state => public_state
)
# new content
StatefulRight.create!(
  :right => new_permission,
  :role => admin_role,
  :workflow_state => nil
)
StatefulRight.create!(
  :right => new_permission,
  :role => admin_role,
  :workflow_state => private_state
)
StatefulRight.create!(
  :right => new_permission,
  :role => admin_role,
  :workflow_state => public_state
)
# create content
StatefulRight.create!(
  :right => create_permission,
  :role => admin_role,
  :workflow_state => nil
)
StatefulRight.create!(
  :right => create_permission,
  :role => admin_role,
  :workflow_state => private_state
)
StatefulRight.create!(
  :right => create_permission,
  :role => admin_role,
  :workflow_state => public_state
)
# edit content
StatefulRight.create!(
  :right => edit_permission,
  :role => admin_role,
  :workflow_state => private_state
)
StatefulRight.create!(
  :right => edit_permission,
  :role => admin_role,
  :workflow_state => public_state
)
# update content
StatefulRight.create!(
  :right => update_permission,
  :role => admin_role,
  :workflow_state => private_state
)
StatefulRight.create!(
  :right => update_permission,
  :role => admin_role,
  :workflow_state => public_state
)
# destroy content
StatefulRight.create!(
  :right => destroy_permission,
  :role => admin_role,
  :workflow_state => private_state
)
StatefulRight.create!(
  :right => destroy_permission,
  :role => admin_role,
  :workflow_state => public_state
)
# update workflow
StatefulRight.create!(
  :right => workflow_permission,
  :role => admin_role
)
# index sections
StatefulRight.create!(
  :right => section_index_permission,
  :role => admin_role
)
# view section
StatefulRight.create!(
  :right => section_view_permission,
  :role => admin_role
)
# view admin index
StatefulRight.create!(
  :right => admin_index_view_permission,
  :role => admin_role
)
# rights on users
StatefulRight.create!(
  :right => users_index_permission,
  :role => admin_role
)
StatefulRight.create!(
  :right => users_show_permission,
  :role => admin_role
)
StatefulRight.create!(
  :right => users_new_permission,
  :role => admin_role
)
StatefulRight.create!(
  :right => users_create_permission,
  :role => admin_role
)
StatefulRight.create!(
  :right => users_edit_permission,
  :role => admin_role
)
StatefulRight.create!(
  :right => users_update_permission,
  :role => admin_role
)
StatefulRight.create!(
  :right => users_destroy_permission,
  :role => admin_role
)

anonymous_role = Role.create!(:name => 'Anonymous')

StatefulRight.create!(
  :right => view_permission,
  :role => anonymous_role,
  :workflow_state => public_state
)