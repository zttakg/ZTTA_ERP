class OrderPdf < Prawn::Document
  def initialize(individual_order)
    super()

    @individual_items = individual_order.individual_items
    @individual_order = individual_order
    header
    text_content
    table_content
    text_content_2
  end

  def header
    bold_font = Rails.root.join('app','assets','fonts', 'lato', 'bold.ttf')
    regular_font = Rails.root.join('app','assets','fonts', 'lato', 'regular.ttf')
    font_families.update(
      "Font" => {
        :bold => bold_font,
        :normal  => regular_font })

    font "Font", :size => 10
  end

  def text_content
    y_position = cursor - 40
    z_position = cursor - 60
    h_position = cursor - 80
    x_position = cursor - 100
    position_120 = cursor - 120

    bounding_box([10, cursor], width: 500, height: 15) do
      text "Дата печати:  #{Time.current.strftime("%d.%m.%Y")}", size: 10
    end

    bounding_box([10, y_position], width: 500, height: 15) do
      text "Заказ № #{@individual_order.id}", size: 15, style: :bold
    end

    bounding_box([10, z_position], width: 500, height: 10) do
      text "Дата оформления:", size: 10
    end

    bounding_box([60, z_position], width: 500, height: 10) do
      horizontal_line 150, 40, at: 0
    end

    bounding_box([260, z_position], width: 500, height: 10) do
      text "Дата завершения:", size: 10
    end

    bounding_box([305, z_position], width: 500, height: 10) do
      horizontal_line 150, 40, at: 0
    end

    bounding_box([10, h_position], width: 500, height: 10) do
      text "Принял:", size: 10
    end

    bounding_box([260, h_position], width: 500, height: 10) do
      text "Куратор:", size: 10
    end

    bounding_box([10, x_position], width: 500, height: 10) do
      text "Тип заказа: Сайт", size: 10
    end

    bounding_box([260, x_position], width: 500, height: 10) do
      text "Тема заказа:", size: 10
    end

    bounding_box([10, position_120], width: 500, height: 10) do
      text "Заказчик: #{@individual_order.last_name} #{@individual_order.name}", size: 10
    end

    bounding_box([260, position_120], width: 500, height: 10) do
      text "Контакты: #{@individual_order.phone_number}, #{@individual_order.email}", size: 10
    end

    bounding_box([10, position_120 - 20], width: 100, height: 30) do
      text "Изготовить к:"
    end

  end

  def text_content_2
    t_position = cursor - 50
    w_position = t_position - 30

    bounding_box([10, t_position], width: 100, height: 30) do
      stroke do
        line_width 1
        horizontal_line(0, 190)
      end

      draw_text "Подпись заказчика", size: 10, at: [55, 20]
    end

    bounding_box([220, t_position], width: 100, height: 30) do
      stroke do
        line_width 1
        horizontal_line(0, 150)
      end

      draw_text "Главный инженер", size: 10, at: [35, 20]
    end

    bounding_box([390, t_position], width: 100, height: 30) do
      stroke do
        line_width 1
        horizontal_line(0, 160)
      end

      draw_text "Куратор", size: 10, at: [60, 20]
    end

    bounding_box([10, t_position - 30], width: 540, height: 30) do
      text "Примечание: #{@individual_order.comment}", size: 10
    end
  end

  def table_content
    table individual_items_rows, position: 10 do
      row(0).font_style = :bold
      row(0).align = :center
      self.column_widths = [80, 40, 170, 40, 29, 56, 62, 63]
    end

    table([['ИТОГО', @individual_items.sum(:count), 'шт.', @total_mass.round(3), '', @sum.round(3)]], column_widths: [290, 40, 29, 56, 62, 63], position: 10)
  end

  def individual_items_rows
    @total_mass = 0
    @sum = 0
    data = [['Обозначение', 'Тип резки', 'Наименование', 'Кол-во', 'Ед.изм.', 'В кг за позицию', 'Стоимость за ед., сом', 'Стоимость, сом']]
    data +=
      @individual_items.map do |individual_item|
        mass = (individual_item.count*individual_item.mass)/1000
        @total_mass += mass
        id = individual_item.id.to_s.gsub(/.{3}(?=.)/, '\0-')
        name = "#{individual_item.material_name} #{individual_item.cut_material.material.thickness} x #{individual_item.width} x #{individual_item.height} мм "
        count = individual_item.count
        type = individual_item.cut_name
        total_price = individual_item.price
        price = total_price/count
        @sum += total_price
      [ id, type[0], name , count, 'шт.', mass, price, total_price ]
      end
  end
end
