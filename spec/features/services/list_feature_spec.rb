feature 'services feature' do
  let(:role) { create :role, name: 'ololo', permission: {'services'=>['edit', 'create']} }
  let(:user) { create :employee, role: role }

  before do
    login_as user

    %w[Пилим Сверлим Отжимаем].each do |title|
      create(:service, title: title)
    end
  end

  scenario 'list services page' do
    visit services_path

    expect(Service.count).to eq(3)
    expect(page).to have_content('Пилим')
    expect(page).to have_content('Сверлим')
    expect(page).to have_content('Отжимаем')
    expect(page).to have_content('Добавить продукцию или услугу')
  end
end
