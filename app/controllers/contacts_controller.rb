class ContactsController < ApplicationController
  before_action :fetch_contact, only: [:edit, :update]
  before_action :authorize

  def update
    if @contact.update(contact_params)
      redirect_to edit_contacts_path, notice: 'Контактные данные обновлены'
    else
      render :edit
    end
  end

  private

  def fetch_contact
    @contact = Contact.first
  end

  def contact_params
    # params.require(:contact).permit(:metalware, :cutting, :email, :address, :social_networks, :fb_link, :instagram_link, :telegram_link, :whatsapp_link, :whatsapp_link_for_metalware, :telegram_link_for_metalware)
    params.require(:contact).permit(:metalware, :cutting, :mak, :gitter, :email, :address, :social_networks, :fb_link,
                                    :instagram_link, :telegram_link, :whatsapp_link, :whatsapp_link_for_metalware,
                                    :whatsapp_link_for_mak, :whatsapp_link_for_gitter, :telegram_link_for_metalware,
                                    :telegram_link_for_mak, :telegram_link_for_gitter)
  end
end
