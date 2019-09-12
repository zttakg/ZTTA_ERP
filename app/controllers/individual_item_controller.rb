class IndividualItemController < ApplicationController
  before_action :fetch_individual_item

  def show
    respond_to do |format|
      format.svg do
        send_data @individual_item.svg, filename: "#{@individual_item.name}.svg", type: 'application/svg'
      end
    end
  end

  private

  def fetch_individual_item
    @individual_item = IndividualItem.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
