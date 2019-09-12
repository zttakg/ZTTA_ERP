module FixtureSeed
  def prepare_cut_and_materials
    Constant.create(margin: 10, machine_preparation_time: 20, material_preparation_cost: 30, programming_cost: 40)

    Cut.create(
      [
        {name: 'Лазерная резка', consumable_cost: 1100, overhead_cost: 250, height_max: 3000, width_max: 3000},
        {name: 'Плазменная резка', consumable_cost: 750, overhead_cost: 350, height_max: 3000, width_max: 3000},
        {name: 'Газовая резка', consumable_cost: 550, overhead_cost: 200, height_max: 3000, width_max: 3000}
      ]
    )

    m1 = Material.create(name: 'Сталь3', thickness: 1, price_per_kg: 57, width_max: 3000, height_max: 1500, density: 2.55)
    m2 = Material.create(name: 'Сталь3', thickness: 5, price_per_kg: 56, width_max: 6000, height_max: 1500, density: 2.5)
    m3 = Material.create(name: 'Сталь3', thickness: 10, price_per_kg: 55, width_max: 6000, height_max: 1500, density: 2.60)
    m4 = Material.create(name: 'Сталь45', thickness: 50, price_per_kg: 55, width_max: 6000, height_max: 1500, density: 2.70)
    m5 = Material.create(name: 'НС глянец', thickness: 1, price_per_kg: 315, width_max: 2500, height_max: 1000, density: 2.80)
    m6 = Material.create(name: 'НС матовая', thickness: 2, price_per_kg: 296, width_max: 3000, height_max: 1500, density: 2.94)

    cut_id1 = Cut.first.id
    cut_id2 = Cut.second.id
    cut_id3 = Cut.third.id

    CutMaterial.create(cut_id: cut_id1, material_id: m1.id, hole_min: 1, consumption: 300, speed: 20000, pierce_price: 1.2)
    CutMaterial.create(cut_id: cut_id2, material_id: m1.id, hole_min: 1, consumption: 1200, speed: 2000, pierce_price: 1.2)
    CutMaterial.create(cut_id: cut_id3, material_id: m1.id, hole_min: 1, consumption: 1200, speed: 1000, pierce_price: 1.3)

    CutMaterial.create(cut_id: cut_id1, material_id: m2.id, hole_min: 1, consumption: 300, speed: 1000, pierce_price: 1.2)
    CutMaterial.create(cut_id: cut_id2, material_id: m2.id, hole_min: 1, consumption: 1200, speed: 1000, pierce_price: 1.2)

    CutMaterial.create(cut_id: cut_id2, material_id: m3.id, hole_min: 2, consumption: 1200, speed: 2000, pierce_price: 1.4)
    CutMaterial.create(cut_id: cut_id3, material_id: m3.id, hole_min: 1, consumption: 1200, speed: 2000, pierce_price: 1.3)

    CutMaterial.create(cut_id: cut_id2, material_id: m4.id, hole_min: 1, consumption: 1200, speed: 1200, pierce_price: 1)

    CutMaterial.create(cut_id: cut_id1, material_id: m5.id, hole_min: 1, consumption: 1400, speed: 2000, pierce_price: 1.4)
    CutMaterial.create(cut_id: cut_id2, material_id: m5.id, hole_min: 1, consumption: 1200, speed: 1200, pierce_price: 1.2)

    CutMaterial.create(cut_id: cut_id2, material_id: m6.id, hole_min: 1, consumption: 1200, speed: 1600, pierce_price: 1)
  end
end
