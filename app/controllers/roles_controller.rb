class RolesController < ApplicationController
  before_action :find_role, only: [:edit, :update]
  before_action :authorize

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    role = Role.new(role_params)

    if role.save
      redirect_to edit_role_path(role), notice: 'Роль добавлена'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @role.update(role_params)
      redirect_to edit_role_path(@role), notice: 'Роль обновлена'
    else
      render :edit
    end
  end

  private

  def find_role
    @role = Role.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def role_params
    params.require(:role).permit(:name, permission: {})
  end
end
