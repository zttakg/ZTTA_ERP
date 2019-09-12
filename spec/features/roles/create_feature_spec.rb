feature 'create role' do
  let(:user) { create :employee, admin: true }

  before { login_as user }

  scenario 'success create role' do
    visit new_role_path

    fill_in 'role[name]', with: 'Name'

    find("div", :text => /\AСписок ролей\z/).check
    find("div", :text => /\AСписок клиентов\z/).check
    click_button('Создать роль')

    role = Role.last
    expect(page).to have_current_path(edit_role_path(role))
    expect(role.name).to eq('Name')
    expect(role.permission).to eq('clients' => ['list'], 'roles' => ['list'])
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'baike' }
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit roles_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
    end
  end
end
