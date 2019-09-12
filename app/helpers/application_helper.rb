module ApplicationHelper
  include TemirtulparHelper

  def display_datetime(datetime)
    datetime.in_time_zone('Asia/Bishkek').strftime("%d-%m-%Y %H:%M")
  end

  def current_class?(status)
    return 'btn btn-outline-primary mb-3 mr-3 float-right active' if request.params[:status] == status

    'btn btn-outline-primary mb-3 mr-3 float-right'
  end

  def humanize(project_module, name)
    ::I18n.t("permissions.#{project_module}.#{name}")
  end

  def render_action_links(permission_name, project_module, label, link_path, method = :get)
    links = ''.html_safe
    if current_employee.allowed_to?(permission_name, project_module)
      links << link_to(label, link_path, method: method, class: 'btn btn-sm btn-outline-primary mb-3 mr-3 float-right')
    end
    links
  end

  def status_check(status)
    case status
    when 'in_progress'
      'В производстве'
    when 'completed'
      'Завершен'
    when 'canceled'
      'Отменен'
    when 'pending_payment'
      'Ожидает оплаты'
    end
  end

  def nav_active(ctrl_name, act_name = '')
    return 'active' if controller_name == ctrl_name && act_name.empty?
    return 'active' if controller_name == ctrl_name && action_name == act_name && !act_name.empty?
  end
end
