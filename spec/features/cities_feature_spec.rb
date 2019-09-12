feature 'cities feature' do
  let(:user) { create :employee }

  before do
    login_as user
    %w[Бишкек Ош Мухасранск].each do |name|
      create(:city, name: name)
    end
  end

  scenario 'must go to the cities page' do
    visit cities_path

    expect(City.count).to eq(3)
    expect(page).to have_content('Бишкек')
    expect(page).to have_content('Ош')
    expect(page).to have_content('Мухасранск')
  end

  context 'create city' do
    scenario 'success create city' do
      visit new_city_path

      within('.new_city') do
        fill_in 'city_name', with: 'Хайфа'

        click_button('Create City')
      end

      City.all.reload
      expect(City.count).to eq(4)
      expect(page).to have_current_path(cities_path)
      expect(page).to have_content('Город добавлен!')
      expect(page).to have_content('Хайфа')
    end

    scenario 'should not create a city' do
      visit new_city_path

      within('.new_city') do
        fill_in 'city_name', with: 'Мухасранск'

        click_button('Create City')
      end

      City.all.reload
      expect(City.count).to eq(3)
    end
  end

  context 'update city' do
    let(:city) { create :city, name: 'Кёнигсберг' }
    let(:city_2) { create :city, name: 'Марбург' }

    scenario 'success update city' do
      visit edit_city_path(city.id)
      within('.edit_city') do
        fill_in 'city_name', with: 'Калининград'

        click_button('Update City')
      end

      city.reload
      expect(page).to have_current_path(cities_path)
      expect(page).to have_content('Данные обновлены!')
      expect(page).to have_content('Калининград')
    end

    scenario 'should not update the name' do
      visit edit_city_path(city_2.id)
      within('.edit_city') do
        fill_in 'city_name', with: 'Мухасранск'

        click_button('Update City')
      end

      city_2.reload
      expect(city_2.name).to eq('Марбург')
    end
  end
end
