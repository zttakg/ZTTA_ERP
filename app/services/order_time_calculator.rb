class OrderTimeCalculator
  attr_reader :current_order, :working_day

  def initialize(order, constant)
    @current_order = order
    @working_day = constant.work_time
  end

  def production_date
    Date.tomorrow + orders_production / working_day
  end

  private

  def orders_production
    paid_orders = IndividualOrder.where(status: :paid)
    paid_orders.sum(:production_time) + current_order.production_time
  end
end
