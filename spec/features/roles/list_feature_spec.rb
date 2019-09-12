feature 'roles feature' do
  before do
    login_as user
    create_list :role, 3
  end

  context 'when the employee is an administrator' do
    let(:user) { create :employee, admin: true }

    scenario 'must see all actions' do
      visit roles_path

      expect(page).to have_css('table tr', count: 5)
      expect(page).to have_content('Добавить роль')
      expect(page).to have_content('Редактировать')
    end
  end

  context 'when CRUD permission' do
    let(:role) { create :role, name: 'baike', permission: {roles: [:list, :create, :edit]} }
    let(:user) { create :employee, role: role }

    scenario 'must see all actions' do
      visit roles_path

      expect(page).to have_css('table tr', count: 5)
      expect(page).to have_content('Добавить роль')
      expect(page).to have_content('Редактировать')
    end
  end

  context 'when there is permission to create' do
    let(:role) { create :role, name: 'baike', permission: {roles: [:list, :create]} }
    let(:user) { create :employee, role: role }

    scenario 'must see only the create button' do
      visit roles_path

      expect(page).to have_css('table tr', count: 5)
      expect(page).to have_content('Добавить роль')
      expect(page).not_to have_content('Редактировать')
    end
  end

  context 'when there is permission to edit' do
    let(:role) { create :role, name: 'ololo', permission: {roles: [:list, :edit]} }
    let(:user) { create :employee, role: role }

    scenario 'should only see the button edit' do
      visit roles_path

      expect(page).to have_css('table tr', count: 5)
      expect(page).not_to have_content('Добавить роль')
      expect(page).to have_content('Редактировать')
    end
  end

  context 'when an employee can only view the list' do
    let(:role) { create :role, name: 'orders', permission: {roles: [:list]} }
    let(:user) { create :employee, role: role }

    scenario 'should not see editing and role creation' do
      visit roles_path

      expect(page).to have_css('table tr', count: 5)
      expect(page).not_to have_content('Добавить роль')
      expect(page).not_to have_content('Редактировать')
    end
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'anonymous' }
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit roles_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
    end
  end
end
