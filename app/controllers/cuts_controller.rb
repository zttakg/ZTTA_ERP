class CutsController < ApplicationController
  before_action :find_cut, only: [:edit, :update]
  before_action :authorize

  def index
    @cuts = Cut.all.order(name: :desc)
  end

  def new
    @cut = Cut.new
  end

  def create
    @cut = Cut.new(cut_params)

    if @cut.save
      redirect_to cuts_path, notice: 'Рез создан'
    else
      render :new
    end
  end

  def update
    if @cut.update(cut_params)
      redirect_to cuts_path, notice: 'Рез обновлен'
    else
      render :edit
    end
  end

  def edit; end

  private

  def find_cut
    @cut = Cut.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def cut_params
    params.require(:cut).permit(:name, :consumable_cost, :overhead_cost, :height_max, :width_max)
  end
end
