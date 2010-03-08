class AnonymousUser

  include Authorization::Entity

  def roles
    assignments = RoleAssignment.find_all_by_entity_id(nil)
    assignments.map{ |a| a.role } unless assignments.nil?
  end
end