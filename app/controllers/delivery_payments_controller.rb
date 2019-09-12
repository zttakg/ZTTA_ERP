class DeliveryPaymentsController < ApplicationController
  before_action :find_delivery_payment, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def index
    @delivery_payments = DeliveryPayment.all
  end

  def new
    @delivery_payment = DeliveryPayment.new
  end

  def create
    @delivery_payment = DeliveryPayment.new(delivery_payment_params)

    if @delivery_payment.save
      redirect_to delivery_payments_path, notice: 'Тип доставки добавлен'
    else
      render :new
    end
  end

  def update
    if @delivery_payment.update(delivery_payment_params)
      redirect_to delivery_payments_path, notice: 'Тип доставки обновлен'
    else
      render :edit
    end
  end

  def destroy
   @delivery_payment.destroy
   redirect_to delivery_payments_path, notice: 'Тип доставки удален'
  end

  private

  def find_delivery_payment
    @delivery_payment = DeliveryPayment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def delivery_payment_params
    params.require(:delivery_payment).permit(:title, :description, :content, :condition)
  end
end
