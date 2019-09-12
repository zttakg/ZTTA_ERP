module RoleHelper
  def check_permission(role, permission)
    permission_module = role.permission[permission.project_module.to_s]

    permission_module.present? ? permission_module.include?(permission.name.to_s) : false
  end
end
