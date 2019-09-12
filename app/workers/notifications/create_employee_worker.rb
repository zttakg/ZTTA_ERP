module Notifications
  class CreateEmployeeWorker
    include Sidekiq::Worker
    include TemirtulparHelper::Services
    sidekiq_options queue: 'erp'

    def perform(phone_number, password)
      msg = "erp.ztta.kg password: #{password}"
      Notification.new(phone_number, 'sms', msg).send
    end
  end
end
