class CitiesController < ApplicationController
  before_action :find_city, only: [:edit, :update]
  before_action :authorize

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to cities_path, notice: 'Город добавлен'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @city.update(city_params)
      redirect_to cities_path, notice: 'Данные обновлены'
    else
      render :edit
    end
  end

  private

  def find_city
    @city = City.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def city_params
    params.require(:city).permit(:name)
  end
end
