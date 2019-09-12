class PageElementsController < ApplicationController
  before_action :find_element, only: [:edit, :update, :destroy]
  before_action :authorize

  def index
    @page_elements = PageElement.all
  end

  def new
    @page_element = PageElement.new
  end

  def create
    element = PageElement.new(element_params)

    if element.save
      redirect_to page_elements_path, notice: 'Элемент добавлен'
    else
      render :new
    end
  end

  def update
    if @page_element.update(element_params)
      redirect_to page_elements_path, notice: 'Элемент обновлен'
    else
      render :edit
    end
  end

  def destroy
    @page_element.destroy
    redirect_to page_elements_path, notice: 'Элемент был удален'
  end

  private

  def find_element
    @page_element = PageElement.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def element_params
    params.require(:page_element).permit(:element_type, :title, :content, :image, :button, :video_link)
  end
end
