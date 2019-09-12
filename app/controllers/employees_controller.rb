class EmployeesController < ApplicationController
  before_action :find_employee, only: [:edit, :update, :change_password, :destroy]
  before_action :authorize

  def index
    @employees = Employee.without_current(current_employee).filtered(params[:sample_filter])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.phone_number = sanitize_params_phone_number(employee_params[:phone_number])

    if @employee.save
      Notifications::CreateEmployeeWorker.perform_async(
        sanitize_db_phone_number(@employee.phone_number),
        employee_params[:password]
      )
      redirect_to employees_path, notice: 'Сотрудник добавлен'
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      if employee_params[:password].present?
        Notifications::CreateEmployeeWorker.perform_async(
          sanitize_db_phone_number(@employee.phone_number),
          employee_params[:password]
        )
      end
      redirect_to employees_path, notice: 'Изменения применены'
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy

    redirect_to employees_path
  end

  private

  def find_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def employee_params
    params.require(:employee).permit(
      :name, :email, :phone_number, :branch, :role_id,
      :telegram_id, :status, :password, :password_confirmation
    )
  end
end
