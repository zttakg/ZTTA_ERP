feature 'list delivery and payment' do
  let(:role) { create :role, name: 'ololo', permission: {"delivery_payments"=>["access"]} }
  let(:user) { create :employee, role: role }

  before do
    login_as user

    DeliveryPayment.conditions.keys.each do |condition|
      create :delivery_payment, title: condition, condition: condition.to_sym
    end
  end

  scenario 'must see the list delivery and payment' do
    visit delivery_payments_path

    expect(page).to have_css('table tr', count: 3)
  end

  context 'when an employee has no permission' do
    let(:user) { create :employee }

    scenario 'must show all orders' do
      visit delivery_payments_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
    end
  end
end
