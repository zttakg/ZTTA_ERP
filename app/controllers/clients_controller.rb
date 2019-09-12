class ClientsController < ApplicationController
  before_action :fetch_client, only: %i[edit update show ban unban]
  before_action :authorize

  def index
    @clients = Client.filtered(params[:sample_filter])
  end

  def new
    @client = Client.new
  end

  def edit_data
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    @client.phone_number = sanitize_params_phone_number(client_params[:phone_number])

    if @client.save
      redirect_to @client, notice: 'Клиент добавлен'
    else
      render :new
    end
  end

  def unban
    redirect_to clients_path, notice: 'Клиент разблокирован' if @client.update(ban_reason: nil, banned_before: nil)
  end

  def update
    if params[:client][:password].blank? && params[:client][:password_confirmation].blank?
      params[:client].delete(:password)
      params[:client].delete(:password_confirmation)
    end
    client_params[:phone_number].delete!(' ').gsub!('(+996)', '')
    if @client.update(client_params)
      redirect_to clients_path, notice: 'Данные клиента изменены'
    else
      render :edit
    end
  end

  private

  def fetch_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def client_params
    params.require(:client).permit(
      :name, :last_name, :phone_number, :email, :password,
      :password_confirmation, :banned_before, :ban_reason, :discount
    )
  end
end
