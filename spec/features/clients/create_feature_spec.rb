feature 'create client' do
  let(:role) { create :role, name: 'baike', permission: {'clients' => ['create']} }
  let(:user) { create :employee, role: role }

  before { login_as user }

  scenario 'success create client' do
    visit new_client_path

    fill_in 'client[name]', with: 'Client'
    fill_in 'client[phone_number]', with: '+12345567890'
    fill_in 'client[email]', with: 'client@example.com'
    fill_in 'client[password]', with: 'qweqwe'
    fill_in 'client[password_confirmation]', with: 'qweqwe'

    click_button('Create Client')

    expect(Client.count).to eq(1)

    client = Client.first
    expect(page).to have_current_path(client_path(client))
    expect(client.name).to eq('Client')
    expect(client.phone_number).to eq('+12345567890')
    expect(client.email).to eq('client@example.com')
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'no name' }
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit new_client_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
      expect(page).to have_current_path(new_client_path)
    end
  end
end
