class ConstructorController < ApplicationController
  before_action :authorize

  def options
    @materials = Material.order(thickness: :asc)
    @cut = Cut.order(name: :desc)
    @cut_materials = CutMaterial.all.map { |el| ["#{el.material_id}_#{el.cut_id}", el] }.to_h
  end
end
