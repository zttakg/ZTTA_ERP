class IndividualItemShipmentsController < ApplicationController
  before_action :fetch_individual_item
  before_action :check_order_status, only: [:new, :create]

  def index
    @individual_item_shipments = @individual_item.individual_item_shipments.order(created_at: :desc)
  end

  def new
    @individual_item_shipment = IndividualItemShipment.new
  end

  def create
    @individual_item_shipment = @individual_item.individual_item_shipments.new(individual_item_shipment_params)
    shipments_count = @individual_item.individual_item_shipments.pluck(:count).sum

    if shipments_count + individual_item_shipment_params[:count].to_i > @individual_item.count
      flash[:alert] = 'Вы не можете отгрузить больше деталей чем указано в заказе'
      render :new and return
    end

    if @individual_item_shipment.save
      redirect_to individual_order_path(@individual_item.individual_order_id), notice: 'Отгрузка добавлена'
    else
      render :new
    end
  end

  private

  def fetch_individual_item
    @individual_item = IndividualItem.find(params[:individual_item_id])
    @individual_order = @individual_item.individual_order
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def check_order_status
    render plain: 'Доступ запрещён', status: :forbidden unless @individual_order.shipped?
  end

  def individual_item_shipment_params
    _params = params.require(:individual_item_shipment).permit(:count)
    _params.merge!(employee_id: current_employee.id)
    _params
  end
end
