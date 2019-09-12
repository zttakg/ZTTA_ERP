class ConstantsController < ApplicationController
  before_action :authorize

  def edit
    @constant = Constant.first
  end

  def update
    @constant = Constant.first

    if @constant.update(constant_params)
      redirect_to constant_edit_path, notice: 'Параметры обновлены'
    else
      render :edit
    end
  end

  private

  def constant_params
    params.require(:constant).permit(
      :margin, :machine_preparation_time, :material_preparation_cost,
      :programming_cost, :programming_time, :work_time, :min_order_sum
    )
  end
end
