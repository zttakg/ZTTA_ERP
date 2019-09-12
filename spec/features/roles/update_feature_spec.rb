feature 'update role' do
  let(:role) { create :role, name: 'ololo', permission: {roles: [:edit]} }
  let(:user) { create :employee, role: role }

  before { login_as user }

  scenario 'success update role' do
    visit edit_role_path(role)

    find("div", :text => /\AСписок ролей\z/).check
    click_button('Обновить роль')

    role.reload
    expect(page).to have_current_path(edit_role_path(role))
    expect(role.permission).to eq('roles' => ['list', 'edit'])
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
