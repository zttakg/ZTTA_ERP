feature 'show order' do
  let(:role) { create :role, name: 'ololo', permission: {'order_statuses_on' => ['pending_payment', 'in_progress'], 'order_statuses_with' => ['finished']} }
  let(:user) { create :employee, role: role }
  let(:client) { create :client }
  let(:order) { create :individual_order, client: client, name: 'Заказ №1', phone_number: '+79369992', status: :in_progress}

  before { login_as user }

  context 'when the user has administrator permission' do
    let(:user) { create :employee, admin: true }

    scenario 'must show all orders' do
      visit individual_order_path(order.id)

      expect(page).to have_content('Сменить')
      expect(page).to have_content('В производстве')
      expect(page).to have_content(order.phone_number)
      expect(page).to have_content(order.name)
    end
  end

  context 'when there is no permission' do
    let(:role) { create :role, name: 'test', permission: {}}
    let(:user) { create :employee, role: role }

    scenario "can't change status" do
      visit individual_order_path(order.id)
      expect(page).not_to have_content("Сменить")
    end
  end
end
