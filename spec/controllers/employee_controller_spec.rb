require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:user) { create :employee, admin: true }
  let(:employee) { create :employee, admin: false }

  context 'check actions by non authorized user' do
    it 'returns http redirect' do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  context 'check actions by authorized user' do
    before(:each) { sign_in(user) }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context 'check actions by authorized user' do
    before(:each) { sign_in(employee) }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(404)
    end
  end
end
