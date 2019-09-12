feature 'edit constant' do
  let(:user) { create :employee }
  let(:constant) { Constant.first }

  before do
    login_as user
    create :constant
  end

  scenario 'success edit constant' do
    visit constant_edit_path
    within('.edit_constant') do
      fill_in 'constant_margin', with: 9379992
      fill_in 'constant_machine_preparation_time', with: 11211111
      fill_in 'constant_material_preparation_cost', with: 22122222
      fill_in 'constant_programming_cost', with: 33333444
      fill_in 'constant_programming_time', with: 3
      fill_in 'constant_work_time', with: 12
      fill_in 'constant_min_order_sum', with: 5000

      click_button('Update Constant')
    end

    constant.reload
    expect(page).to have_current_path(constant_edit_path)
    expect(page).to have_content('Update successful')
    expect(constant.margin).to eq(9379992)
    expect(constant.machine_preparation_time).to eq(11211111)
    expect(constant.material_preparation_cost).to eq(22122222)
    expect(constant.programming_cost).to eq(33333444)
    expect(constant.programming_time).to eq(3)
    expect(constant.work_time).to eq(12)
    expect(constant.min_order_sum).to eq(5000)
  end

  scenario 'unsuccess edit constant' do
    visit constant_edit_path
    within('.edit_constant') do
      fill_in 'constant_margin', with: ''
      fill_in 'constant_machine_preparation_time', with: ''
      fill_in 'constant_material_preparation_cost', with: ''
      fill_in 'constant_programming_cost', with: ''

      click_button('Update Constant')
    end

    expect(page).to have_no_content('Update successful')
    expect(page).to have_content('Коэффициент жадности должен быть заполнен')
    expect(page).to have_content('Время подготовки станка должно быть заполнено')
    expect(page).to have_content('Стоимость подготовки материалов должна быть заполнена')
    expect(page).to have_content('Стоимость программирования должна быть заполнена')
  end
end
