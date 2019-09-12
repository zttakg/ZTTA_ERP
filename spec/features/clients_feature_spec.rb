feature 'clients feature' do
  let(:role) { create :role, name: 'ololo', permission: {'clients' => ['list']} }
  let(:user) { create :employee, role: role }

  before do
    login_as user
    create_list :client, 10
  end

  context 'when a user has only the permission to view the list' do
    scenario 'should not see the action' do
      visit clients_path

      expect(page).to have_css('table tr', count: 11)
      expect(page).not_to have_content('Заблокировать')
      expect(page).not_to have_content('Добавить клиента')
    end
  end

  context 'when the user is an admin' do
    let(:user) { create :employee, admin: true }

    scenario 'should see all actions' do
      visit clients_path
      expect(page).to have_css('table tr', count: 11)
      expect(page).to have_content('Заблокировать')
      expect(page).to have_content('Добавить клиента')
    end
  end
end
