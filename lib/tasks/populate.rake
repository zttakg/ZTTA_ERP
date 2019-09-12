namespace :db do
  desc 'Populate database with dummy data'
  task populate: :environment do
    full_reset

    Cut.create [
      {name: 'Лазерная резка', consumable_cost: 100, overhead_cost: 90, height_max: 30, width_max: 50},
      {name: 'Плазменная резка', consumable_cost: 111, overhead_cost: 99, height_max: 40, width_max: 60},
      {name: 'Газовая резка', consumable_cost: 110, overhead_cost: 100, height_max: 50, width_max: 40}
    ]
    puts 'Cuts created'

    Role.create name: 'Test'
    puts 'Role created'

    Employee.create email: 'test@gmail.com', password: '12345678', name: 'Testname', admin: true
    puts 'Employee created'

    Client.create email: 'test@gmail.com', password: '12345678', name: 'Testname'
    puts 'Client created'

    Contact.create(
      metalware: '+996 551 155 069',
      cutting: '+996 551 155 069',
      email: 'info@temirtulpar.com',
      address: 'Кыргызстан, г. Бишкек, пр. Чуй 2'
    )
    puts 'Created created'

    Constant.create(
      margin: 10,
      machine_preparation_time: 20,
      material_preparation_cost: 30,
      programming_cost: 40,
      programming_time: 1,
      work_time: 8
    )
    puts 'Constant created'

    m1 = Material.create(name: 'Сталь3', thickness: 1, price_per_kg: 57, width_max: 3000, height_max: 1500, density: 1)
    m2 = Material.create(name: 'Сталь3', thickness: 5, price_per_kg: 56, width_max: 6000, height_max: 1500, density: 1)
    m3 = Material.create(name: 'Сталь3', thickness: 10, price_per_kg: 55, width_max: 6000, height_max: 1500, density: 1)
    m4 = Material.create(name: 'Сталь45', thickness: 50, price_per_kg: 55, width_max: 6000, height_max: 1500, density: 1)
    m5 = Material.create(name: 'НС глянец', thickness: 1, price_per_kg: 315, width_max: 2500, height_max: 1000, density: 1)
    m6 = Material.create(name: 'НС матовая', thickness: 2, price_per_kg: 296, width_max: 3000, height_max: 1500, density: 1)

    cut_id1 = Cut.first.id
    cut_id2 = Cut.second.id
    cut_id3 = Cut.third.id

    CutMaterial.create(cut_id: cut_id1, material_id: m1.id, hole_min: 1, consumption: 300, speed: 20_000, pierce_price: 1.2)
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

  def full_reset
    puts 'Reset old data'
    Rake::Task['db:reset'].invoke
    puts '...reset done'
  end

  def dummy(title, number = 1)
    puts "Creating dummy #{title}..."
    number.times { yield }
    puts '...done'
  end
end
