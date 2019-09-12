class ApplicationController < ActionController::Base
  include TemirtulparHelper::View::PhoneNumberHelper

  before_action :authenticate_employee!
  protect_from_forgery with: :exception

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def authorize(ctrl = params[:controller], action = params[:action])
    return render_404 unless current_employee.allowed_to?(controller: ctrl, action: action)
  end
end
