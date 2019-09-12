feature 'log in feature' do
  let(:user) { create :employee }

  context 'log in' do
    scenario 'success log in' do
      visit new_employee_session_path
      within('.simple_form') do
        fill_in 'employee_email', with: user.email
        fill_in 'employee_password', with: user.password
        click_button('Войти')
        expect(page).to have_current_path(root_path)
      end
    end

    scenario 'log in with wrong params' do
      visit new_employee_session_path
      within('.simple_form') do
        fill_in 'employee_email', with: 'wrong_email@example.com'
        fill_in 'employee_password', with: 'wrong_password'
        click_button('Войти')
        expect(page).to have_current_path(new_employee_session_path)
      end
    end
  end
end
