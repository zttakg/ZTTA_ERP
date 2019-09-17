feature 'contacts feature' do
  let(:role) { create :role, name: 'test', permission: {'contacts' => ['edit']} }
  let(:user) { create :employee, role: role }

  before do
    create :contact, metalware: '+9379992', cutting: '+9379992', mak: '+9379992', gitter: '+9379992', email: 'test@email.com', address: 'st.St'
    login_as user
  end

  scenario 'should change contact information' do
    visit edit_contacts_path

    within('.contact_form') do
      fill_in 'contact[metalware]', with: '+ 996 123 11 11 11'
      fill_in 'contact[cutting]',   with: '+ 996 123 22 22 22'
      fill_in 'contact[mak]', with: '+ 996 123 33 33 33'
      fill_in 'contact[gitter]', with: '+ 996 123 44 44 44'
      fill_in 'contact[email]',     with: 'test@test-email.com'
      fill_in 'contact[address]',   with: 'st. Test 42/2'

      click_button('Сохранить')
    end

    contact = Contact.first
    expect(contact.metalware).to eq('+ 996 123 11 11 11')
    expect(contact.cutting).to eq('+ 996 123 22 22 22')
    expect(contact.mak).to eq('+ 996 123 33 33 33')
    expect(contact.gitter).to eq('+ 996 123 44 44 44')
    expect(contact.email).to eq('test@test-email.com')
    expect(contact.address).to eq('st. Test 42/2')
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'anonymous' }
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit edit_contacts_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
    end
  end
end
