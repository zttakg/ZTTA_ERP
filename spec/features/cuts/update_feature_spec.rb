feature 'edit cut' do
  let(:user) { create :employee }
  let(:cut)  { create :cut, name: 'first' }

  before { login_as user }

  scenario 'success update cut' do
    visit edit_cut_path(cut.id)
    within('.edit_cut') do
      fill_in 'cut_name', with: 'second'
      fill_in 'cut_consumable_cost', with: '123123'
      fill_in 'cut_width_max', with: '1111'

      click_button('Update Cut')
    end

    cut.reload
    expect(page).to have_current_path(cuts_path)
    expect(page).to have_content('Update successful')
    expect(cut.name).to eq('second')
  end
end
