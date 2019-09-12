feature 'create material' do
  let(:user) { create :employee }

  before { login_as user }

  scenario 'success create material' do
    visit new_material_path
    within('.new_material') do
      fill_in 'material_name', with: 'Name'
      fill_in 'material_price_per_kg', with: '123123'
      fill_in 'material_thickness', with: '12312'
      fill_in 'material_height_max', with: '12122'
      fill_in 'material_width_max', with: '1111'
      fill_in 'material_density', with: '1111'

      click_button('Create Material')
    end

    expect(Material.all.size).to eq(1)
    expect(page).to have_current_path(material_path(Material.first.id))
    expect(page).to have_content('The material was created!')
  end
end
