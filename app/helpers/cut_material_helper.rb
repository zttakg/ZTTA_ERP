module CutMaterialHelper
  def check_cut_material(material, cut)
    if cut.cut_materials.where(material: material).present?
      cut.cut_materials.where(material: material)
    else
      @material.cut_materials.build(cut: cut)
    end
  end
end
