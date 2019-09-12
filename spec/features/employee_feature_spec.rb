feature 'employees feature' do
  let(:user) { create :employee }

  before do
    login_as user
    10.times do
      create :employee
    end
  end

  context 'employee index page' do
    scenario 'no filter' do
      visit employees_path

      expect(page).to have_css('table tr', count: 11)
    end
  end

  scenario 'user edit' do
    visit edit_employee_path(user.id)

    fill_in 'employee_name', with: 'Employee'
    fill_in 'employee_phone_number', with: '+12345567890'
    fill_in 'employee_email', with: 'employee@example.com'

    click_button('Изменить')

    user.reload
    expect(page).to have_current_path(employees_path)
    expect(user.name).to eq('Employee')
    expect(user.phone_number).to eq('+12345567890')
    expect(user.email).to eq('employee@example.com')
  end

  scenario 'user creation' do
    visit new_employee_path

    fill_in 'employee_name', with: 'Employee'
    fill_in 'employee_phone_number', with: '+12345567890'
    fill_in 'employee_email', with: 'employee@example.com'
    fill_in 'employee_branch', with: 'branch'
    fill_in 'employee_telegram_id', with: 'Telegram ID'
    fill_in 'employee_password', with: 'qweqwe'
    fill_in 'employee_password_confirmation', with: 'qweqwe'

    click_button('Добавить')

    expect(Employee.count).to eq(12)
    expect(page).to have_current_path(employee_path(Employee.last))
    expect(page).to have_content('Employee')
    expect(page).to have_content('+12345567890')
    expect(page).to have_content('employee@example.com')
    expect(page).to have_content('branch')
    expect(page).to have_content('Telegram ID')
  end
end
