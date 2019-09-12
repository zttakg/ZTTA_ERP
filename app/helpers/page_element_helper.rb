module PageElementHelper


  def element_type_array(e)
    page_element = e.element_type
    array_of_element_type = PageElement.element_types.map { |s|  s.first }
    array_without_slide = PageElement.where.not(element_type: :slide).map{ |x| x.element_type }
    array = array_of_element_type - array_without_slide
    array.push(page_element) unless page_element.nil?
    return array
  end
end
