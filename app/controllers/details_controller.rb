class DetailsController < ApplicationController
  before_action :find_detail, only: [:edit, :update, :show, :request_calculation_svg]
  before_action :check_svg, only: [:update, :request_calculation_svg, :merge_params]
  before_action :merge_params, only: [:update, :request_calculation_svg]
  before_action :authorize

  def index
    status = params[:status].present? ? params[:status] : 'expects_assessed'
    @details = Detail.custom_by_status(status)
  end

  def update
    DetailUpdate.new(@detail, @params).update
    redirect_to @detail, notice: 'Деталь обновлена'
  end

  def edit; end

  def show; end

  private

  def find_detail
    @detail = Detail.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def check_svg
    @svg = detail_params[:svg].read if detail_params[:svg].present?
  end

  def merge_params
    @params = {status: detail_params[:status]}

    return @params if @svg.nil?
    @params.merge!(svg: @svg)
    @params.merge!(request_calculation_svg)
  end

  def request_calculation_svg
    uri = URI("#{ENV['ZAVOD_URL']}/api/details/calculation_svg")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Post.new(uri.path, 'Content-Type': 'application/json')
    req.body = {detail_id: @detail.id, svg: @svg}.to_json
    res = http.request(req)
    json = JSON.parse(res.body)

    return json if res.is_a? Net::HTTPSuccess
  end

  def detail_params
    params.require(:detail).permit(:svg, :status)
  end
end
