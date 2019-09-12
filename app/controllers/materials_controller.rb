class MaterialsController < ApplicationController
  before_action :authorize

  def index
    @materials = Material.filtered(params[:sample_filter]).order(thickness: :asc)
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)

    if @material.save
      create_or_update_cut_materials
      redirect_to materials_path, notice: 'Материал создан'
    else
      render :new
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    if @material.update(material_params)
      create_or_update_cut_materials
      redirect_to materials_path, notice: 'Материал обновлен'
    else
      render :edit
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path, notice: 'Материал удален'
  rescue ActiveRecord::InvalidForeignKey
    redirect_to materials_path, alert: ' Невозможно удалить! Некоторые детали используют данный материал'
  end

  private

  def create_or_update_cut_materials
    return unless cut_materials_params[:cut_materials_attributes].present?

    cut_materials_params[:cut_materials_attributes].each do |cut_material_params|
      cut_material = CutMaterial.find_by(id: cut_material_params.second[:id])
      check_status = cut_material_params.second[:status].to_i

      if cut_material && check_status == 1
        cut_material.update(cut_material_params.second.except(:status))
      elsif cut_material && check_status.zero?
        cut_material.destroy
      elsif cut_material.nil? && check_status == 1
        @material.cut_materials.create(cut_material_params.second.except(:status))
      end
    end
  end

  def material_params
    params.require(:material).permit(:name, :price_per_kg, :thickness, :height_max, :width_max, :in_stock, :density)
  end

  def cut_materials_params
    params.require(:material).permit(
      cut_materials_attributes: [:hole_min, :consumption, :speed, :pierce_price, :id, :cut_id, :status]
    )
  end
end
