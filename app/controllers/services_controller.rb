class ServicesController < ApplicationController
  before_action :fetch_service, only: [:edit, :update, :destroy]
  before_action :authorize, except: [:index]

  def index
    @services = Service.all.order(title: :asc)
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def update
    if @service.update(service_params)
      redirect_to services_path
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to services_path
  end

  private

  def fetch_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :cover, :svg)
  end
end
