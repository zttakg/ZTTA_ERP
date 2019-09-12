feature 'edit material' do
  let(:user) { create :employee }
  let(:material) { create :material, name: 'ololo' }

  before { login_as user }

  scenario 'success update material' do
    visit edit_material_path(material.id)
    within('.edit_material') do
      fill_in 'material_name', with: 'trololo'
      fill_in 'material_price_per_kg', with: '12'
      fill_in 'material_thickness', with: '123'
      fill_in 'material_height_max', with: '12'
      fill_in 'material_width_max', with: '11'
      fill_in 'material_density', with: '1111'
      choose 'material_in_stock_false'

      click_button('Update Material')
    end

    material.reload

    expect(page).to have_current_path(materials_path)
    expect(page).to have_content('Update successful')
    expect(material.name).to eq('trololo')
    expect(material.price_per_kg).to eq(12.to_d)
    expect(material.thickness).to eq(123)
    expect(material.density).to eq(1111)
    expect(material.height_max).to eq(12)
    expect(material.width_max).to eq(11)
    expect(material.in_stock).to eq(false)
  end
end
