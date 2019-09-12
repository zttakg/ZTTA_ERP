feature 'show client' do
  let(:role) { create :role, name: 'baike', permission: {'clients' => ['update']} }
  let(:user) { create :employee, role: role }
  let(:client) { create :client }

  before { login_as user }

  scenario 'must show client' do
    visit client_path(client)

    expect(page).not_to have_content(client.name)
    expect(page).not_to have_content(client.email)
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'no name', permission: {} }
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit client_path(client)

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
      expect(page).to have_current_path(client_path(client))
    end
  end
end
