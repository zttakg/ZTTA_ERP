feature 'edit service feature' do
  let(:role) { create :role, name: 'ololo', permission: {'services'=>['edit']} }
  let(:user) { create :employee, role: role }
  let(:service) { create :service, title: 'Доставка' }

  before { login_as user }

  scenario 'update service' do
    visit edit_service_path(service.id)

    within('.edit_service') do
      fill_in 'service_title', with: 'Доп. услуга'
      fill_in 'service_description', with: 'Дополнительная услуга'
      click_button('Сохранить')
    end

    service.reload
    expect(page).to have_current_path(services_path)
    expect(page).to have_content('Доп. услуга')
    expect(service.description).to have_content('Дополнительная услуга')
  end
end
