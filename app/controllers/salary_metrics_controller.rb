class SalaryMetricsController < ApplicationController
  def index
    result = SalaryMetricsService.new(params).call

    if result[:status] == :bad_request
      render json: { error: result[:error] }, status: :bad_request
    else
      render json: result[:data], status: :ok
    end
  end
end
