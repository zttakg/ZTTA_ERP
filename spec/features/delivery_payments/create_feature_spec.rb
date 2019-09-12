feature 'list delivery and payment' do
  let(:role) { create :role, name: 'ololo', permission: {"delivery_payments"=>["access"]} }
  let(:user) { create :employee, role: role }

  before do
    login_as user
  end

  scenario 'must be successfully created' do
    visit new_delivery_payment_path

    within('.new_delivery_payment') do
      fill_in 'delivery_payment_title', with: 'Заголовок'
      fill_in 'delivery_payment_description', with: 'Описание'
      fill_in 'delivery_payment_content', with: 'Содержание'
      click_button('Create Delivery payment')
    end

    delivery_payment = DeliveryPayment.first
    expect(DeliveryPayment.count).to eq(1)
    expect(delivery_payment.title).to eq('Заголовок')
    expect(delivery_payment.description).to eq('Описание')
    expect(delivery_payment.content).to eq('Содержание')
  end

  context 'when an employee has no permission' do
    let(:user) { create :employee }

    scenario 'must show all orders' do
      visit new_delivery_payment_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
    end
  end
end
