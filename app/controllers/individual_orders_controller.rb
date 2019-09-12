class IndividualOrdersController < ApplicationController
  before_action :fetch_order, only: [:status_update]
  before_action :authorize, except: :status_update

  def index
    @individual_orders = IndividualOrder.where(status: available_statuses).filtered(params[:sample_filter])
  end

  def show
    @individual_order = IndividualOrder.find(params[:id])
    @statuses = statuses_for_updates
    respond_pdf
  end

  def status_update
    OrderStatusUpdate.new(current_employee, @order, params).run
    redirect_to @order, notice: 'Статус заказа успешно обновлен!'
  rescue Errors::PermissionError
    redirect_to @order, alert: 'Не хватает прав на изменение заказа'
  end

  private

  def respond_pdf
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@individual_order)
        send_data pdf.render, filename: "заказ_#{@individual_order.id}.pdf", type: 'application/pdf'
      end
    end
  end

  def fetch_order
    @order = IndividualOrder.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def statuses_for_updates
    if current_employee.admin?
      IndividualOrder.statuses.keys
    else
      current_employee.role.permission['order_statuses_on']
    end
  end

  def available_statuses
    if current_employee.admin?
      IndividualOrder.statuses.keys
    elsif current_employee.role
      arr = []
      arr << current_employee.role.permission['order_statuses_on']
      arr << current_employee.role.permission['order_statuses_with']
      arr.flatten.compact
    end
  end
end
