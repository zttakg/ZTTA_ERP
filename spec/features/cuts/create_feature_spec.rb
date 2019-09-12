feature 'create cut' do
  let(:user) { create :employee }

  before { login_as user }

  scenario 'success create cut' do
    visit new_cut_path

    within('.new_cut') do
      fill_in 'cut_name', with: 'Name'
      fill_in 'cut_consumable_cost', with: '123123'
      fill_in 'cut_overhead_cost', with: '12312'
      fill_in 'cut_height_max', with: '12122'
      fill_in 'cut_width_max', with: '1111'

      click_button('Create Cut')
    end

    expect(Cut.all.size).to eq(1)
    expect(page).to have_current_path(cut_path(Cut.first.id))
    expect(page).to have_content('The cut was created!')
  end
end
