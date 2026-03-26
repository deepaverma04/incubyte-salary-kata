class SalaryMetricsService
  def initialize(params)
    @country = params[:country]
    @job_title = params[:job_title]
  end

  def call
    return error_response if invalid_params?
    return error_response("Provide either country or job_title, not both") if both_params?
    return country_metrics if @country.present?

    job_title_metrics
  end

  private

  def invalid_params?
    @country.blank? && @job_title.blank?
  end

  def both_params?
    @country.present? && @job_title.present?
  end

  def error_response(msg = "Missing params")
    { status: :bad_request, error: msg }
  end

  def country_metrics
    employees = Employee.where(country: @country)

    {
      data: {
        minimum_salary: employees.minimum(:salary)&.to_s,
        maximum_salary: employees.maximum(:salary)&.to_s,
        average_salary: employees.average(:salary)&.to_s
      },
      status: :ok
    }
  end

  def job_title_metrics
    employees = Employee.where(job_title: @job_title)

    {
      data: {
        average_salary: employees.average(:salary)&.to_s
      },
      status: :ok
    }
  end
end