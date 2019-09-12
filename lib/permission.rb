require 'access_control'

AccessControl.map do |map|
  map.project_module :clients do |m|
    m.permission :list, clients: [:index, :autocomplete]
    m.permission :show, clients: [:show]
    m.permission :create, clients: [:create, :new]
    m.permission :edit, clients: [:update, :edit]
    m.permission :ban, clients: [:ban, :unban]
  end

  map.project_module :individual_orders do |m|
    m.permission :list, individual_orders: [:index]
    m.permission :show, individual_orders: [:show]
  end

  %i[order_statuses_with order_statuses_on].each do |p_m|
    map.project_module p_m do |m|
      IndividualOrder.statuses.keys.each do |status|
        m.permission status.to_sym, orders: [:status_update]
      end
    end
  end

  map.project_module :employees do |m|
    m.permission :list, employees: [:index]
    m.permission :create, employees: [:create, :new]
    m.permission :edit, employees: [:update, :edit, :change_password]
    m.permission :destroy, employees: [:destroy]
  end

  map.project_module :cuts do |m|
    m.permission :list, cuts: [:index]
    m.permission :create, cuts: [:create, :new]
    m.permission :edit, cuts: [:update, :edit]
  end

  map.project_module :constants do |m|
    m.permission :edit, constants: [:update, :edit]
  end

  map.project_module :constructor do |m|
    m.permission :show, constructor: [:options]
  end

  map.project_module :materials do |m|
    m.permission :list, materials: [:index]
    m.permission :create, materials: [:create, :new]
    m.permission :edit, materials: [:update, :edit]
    m.permission :destroy, materials: [:destroy]
  end

  map.project_module :details do |m|
    m.permission :list, details: [:index]
    m.permission :show, details: [:show]
    m.permission :edit, details: [:update, :edit]
  end

  map.project_module :cities do |m|
    m.permission :list, cities: [:index]
    m.permission :create, cities: [:create, :new]
    m.permission :edit, cities: [:update, :edit]
  end

  map.project_module :roles do |m|
    m.permission :list, roles: [:index]
    m.permission :create, roles: [:create, :new]
    m.permission :edit, roles: [:edit, :update]
  end

  map.project_module :contacts do |m|
    m.permission :edit, contacts: [:update, :edit]
  end

  map.project_module :page_elements do |m|
    m.permission :list, page_elements: [:index]
    m.permission :create, page_elements: [:create, :new]
    m.permission :edit, page_elements: [:update, :edit]
    m.permission :destroy, page_elements: [:destroy]
  end

  map.project_module :services do |m|
    m.permission :list, services: [:index]
    m.permission :edit, services: [:update, :edit]
    m.permission :create, services: [:create, :new]
    m.permission :destroy, services: [:destroy]
  end

  map.project_module :delivery_payments do |m|
    m.permission :access, delivery_payments: [:index, :new, :create, :edit, :update, :destroy]
  end

  map.project_module :notification do |m|
    m.permission :order_new, notification: [:index]
    m.permission :order_paid_by_card, notification: [:index]
    m.permission :order_in_production, notification: [:create, :new]
    m.permission :order_cancelled, notification: [:edit, :update]
    m.permission :order_shipped, notification: [:edit, :update]
    m.permission :order_finished, notification: [:edit, :update]
    m.permission :detail_for_evaluation, notification: [:edit, :update]
    m.permission :detail_new, notification: [:index]
  end
end
