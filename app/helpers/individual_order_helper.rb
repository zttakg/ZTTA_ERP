module IndividualOrderHelper
  def check_order_permission(individual_order)
    current_employee.admin? ||
    current_employee.role.permission['order_statuses_with'] &&
    current_employee.role.permission['order_statuses_with'].include?(individual_order.status) &&
    current_employee.role.permission['order_statuses_on'].present?
  end

  def order_status_color(status)
    case status
    when 'pending_payment'
      'label-info'
    when 'paid'
      'label-primary'
    when 'in_progress'
      'label-warning'
    when 'canceled'
      'label-danger'
    when 'finished'
      'label-success'
    when 'proof_payment'
      'label-success'
    when 'payment_error'
      'label-danger'
    end
  end
end
