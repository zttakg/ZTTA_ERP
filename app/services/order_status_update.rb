class OrderStatusUpdate
  include TemirtulparHelper::View::PhoneNumberHelper

  attr_reader :current_employee, :order, :old_status, :new_status

  def initialize(current_employee, order, params = {})
    @current_employee = current_employee
    @order = order
    @old_status = @order.status
    @new_status = params[:individual_order][:status]
  end

  def run
    check_update_permission
    status_update
    create_history
    send_notification
  end

  private

  def check_update_permission
    return if current_employee.allowed_to?(new_status, 'order_statuses_on')
    raise Errors::PermissionError, "Action: No permission"
  end

  def status_update
    constant = Constant.first
    time_c = OrderTimeCalculator.new(order, constant) if new_status == 'paid'
    order.update(status: new_status, production_date: time_c.try(:production_date))
  end

  def create_history
    order.order_histories.create(
      employee_id: current_employee.id,
      status_from: old_status,
      status_to: new_status
    )
  end

  def send_notification
    phone_number = sanitize_db_phone_number(order.phone_number)
    case new_status
    when 'in_progress'
      msg = "Заказ '№ #{order.id}' передан в производство"
      ids = fetch_telegram_ids('order_in_production')
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
      SendNotificationJob.perform_async(ids, 'tg', msg)
    when 'finished'
      # msg = "Заказ '№ #{order.id}' завершён"
      # ids = fetch_telegram_ids('order_finished')
      # SendNotificationJob.perform_async([phone_number], 'sms', msg)
      # SendNotificationJob.perform_async(ids, 'tg', msg)
      check_deliver_type(phone_number)
    when 'canceled'
      msg = "Заказ '№ #{@order.id}' был отменен"
      ids = fetch_telegram_ids('order_canceled')
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
      SendNotificationJob.perform_async(ids, 'tg', msg)
    when 'proof_payment'
      msg = "Заказ '№ #{order.id}': платеж получен."
      ids = fetch_telegram_ids('order_paid_by_card')
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
      SendNotificationJob.perform_async(ids, 'tg', msg)
    when 'payment_error'
      msg = "Заказ '№ #{order.id}': ошибка платежа ."
      ids = fetch_telegram_ids('order_payment_error')
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
      SendNotificationJob.perform_async(ids, 'tg', msg)
    end
  end

  #pending_payment paid in_progress canceled finished proof_payment payment_error

  def check_deliver_type(phone_number)
    ids = fetch_telegram_ids('order_finished')
    msg =
      if order.pick_up?
        "Заказ '№ #{order.id}' изготовлен. Размещен на склад самовывоза."
      else
        "Заказ '№ #{order.id}' отгружен. Доставка осуществляется по адресу: '#{order.delivery_address}'"
      end
    SendNotificationJob.perform_async(ids, 'tg', msg)
    SendNotificationJob.perform_async([phone_number], 'sms', msg)
  end

  def fetch_telegram_ids(status)

    roles = Role.where("permission ->> 'notification' LIKE '%#{status}%' ")
    employees = Employee.where(role_id: roles.ids)
    telegram_ids = employees.pluck(:telegram_id).uniq
    telegram_ids
  end

end
