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

  def detail_status_color(status)
    case status
    when 'not_assessed'
      'label-danger'
    when 'assessed'
      'label-info'
    when 'expects_assessed'
      'label-primary'
    when 'appraised'
      'label-success'
    when 'not_send'
      'label-warning'
    end
  end
end
