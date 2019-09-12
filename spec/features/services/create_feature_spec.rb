feature 'create service feature' do
  let(:role) { create :role, name: 'ololo', permission: {"services"=>["create"]} }
  let(:user) { create :employee, role: role }

  before do
    login_as user

    %w[Услуга Товар Продукция].each do |title|
      create(:service, title: title)
    end
  end

  scenario 'create service' do
    visit new_service_path

    within('.new_service') do
      fill_in 'service_title', with: 'Новая услуга'
      fill_in 'service_description', with: 'Текстовое описание'
      click_button('Сохранить')
    end

    expect(Service.count).to eq(4)
    expect(Service.last.description).to eq('Текстовое описание')
    expect(page).to have_current_path(services_path)
    expect(page).to have_content('Новая услуга')
  end
end
