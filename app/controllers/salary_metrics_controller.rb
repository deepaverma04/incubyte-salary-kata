class SalaryMetricsController < ApplicationController
  def index
    # ❌ No params
    if params[:country].blank? && params[:job_title].blank?
      return render json: { error: "Missing params" }, status: :bad_request
    end

    # ✅ Country case
    if params[:country].present?
      employees = Employee.where(country: params[:country])

      return render json: {
        minimum_salary: employees.minimum(:salary)&.to_s,
        maximum_salary: employees.maximum(:salary)&.to_s,
        average_salary: employees.average(:salary)&.to_s
      }, status: :ok
    end

    # ✅ Job title case
    if params[:job_title].present?
      employees = Employee.where(job_title: params[:job_title])

      return render json: {
        average_salary: employees.average(:salary)&.to_s
      }, status: :ok
    end
  end
end