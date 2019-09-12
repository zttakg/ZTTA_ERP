feature 'list orders' do
  let(:role) { create :role, name: 'ololo', permission: {'order_statuses_on' => ['pending_payment', 'in_progress'], 'order_statuses_with' => ['finished']} }
  let(:user) { create :employee, role: role }
  let(:client) { create :client }

  before do
    login_as user

    IndividualOrder.statuses.keys.each do |status|
      create :individual_order, client: client, status: status.to_sym
    end
  end

  scenario 'should show orders for available statuses' do
    visit individual_orders_path

    expect(page).to have_css('table tr', count: 4)
  end

  context 'when the user has administrator permission' do
    let(:user) { create :employee, admin: true }

    scenario 'must show all orders' do
      visit individual_orders_path

      expect(page).to have_css('table tr', count: 6)
    end
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'test', permission: {}}
    let(:user) { create :employee, role: role }

    scenario 'should see an error' do
      visit individual_orders_path

      expect(page).not_to have_content("The page you were looking for doesn't exist. (404)")
    end
  end
end
