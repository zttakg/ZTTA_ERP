class DetailUpdate
  include TemirtulparHelper::View::PhoneNumberHelper
  attr_reader :detail, :params, :status

  def initialize(detail, params = {})
    @detail = detail
    @params = params
    @status = params[:status]
  end

  def update
    add_width_height_to_params if @params[:svg].present?
    @detail.update(@params)
    send_notification
  end

  private

  def add_width_height_to_params
    svg = @params[:svg]
    viewBox = /viewBox="(\d.*) (\d.*) (\d.*) (\d.*)"/.match(svg)
    @params[:width] = viewBox[3]
    @params[:height] = viewBox[4]
    @params
  end

  def send_notification
    phone_number = sanitize_db_phone_number(detail.client.phone_number)
    case status
    when 'assessed'
      msg = "Ваша деталь '#{detail.name}' принята на обработку."
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
    when 'not_assessed'
      msg = "Вашу деталь '#{detail.name}' невозможно оценить. Обратитесь к менеджеру"
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
    when 'appraised'
      msg = "Стоимость детали '#{detail.name}' в кол-ве #{detail.count}шт. стоит '#{detail.price}' сом."
      SendNotificationJob.perform_async([phone_number], 'sms', msg)
    end
  end
end
