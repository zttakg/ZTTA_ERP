feature 'client password reset' do
  let(:role) { create :role, name: 'baike', permission: {'clients' => ['edit']} }
  let(:user) { create :employee, role: role }
  let(:client) { create :client }

  before { login_as user }

  scenario 'must successfully change the password' do
    visit edit_client_path(client)

    fill_in 'client[password]', with: 'qweqwe'
    fill_in 'client[password_confirmation]', with: 'qweqwe'

    click_button('Обновить')

    expect(page).to have_current_path(client_path(client))
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'no name', permission: {} }
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit edit_client_path(client)

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
      expect(page).to have_current_path(edit_client_path(client))
    end
  end
end
