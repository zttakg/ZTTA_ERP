class SessionsController < Devise::SessionsController
  include TemirtulparHelper::View::PhoneNumberHelper
  layout 'devise_application'

  def create
    resource = Employee.find_for_database_authentication phone_number: sanitize_params_phone_number(params[:employee][:phone_number])
    return invalid_login_attempt unless resource

    if resource.valid_password? params[:employee][:password]
      sign_in :employee, resource
      return redirect_to root_path
    end

    invalid_login_attempt
  end

  private

  def invalid_login_attempt
    redirect_to new_employee_session_path
  end
end
