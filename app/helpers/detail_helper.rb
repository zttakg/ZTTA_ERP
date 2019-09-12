module DetailHelper
  def detail_status(status)
    case status
    when 'not_assessed'
      'невозможно оценить'
    when 'assessed'
      'оценивается'
    when 'expects_assessed'
      'ожидает оценки'
    when 'appraised'
      'оценен'
    when 'not_send'
      'не отправлен'
    end
  end
end
