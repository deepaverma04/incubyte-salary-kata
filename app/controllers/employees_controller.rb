class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy, :salary]

  def index
    render json: Employee.all
  end

  def show
    render json: @employee
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: employee.errors, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  def salary
			gross = @employee.salary
			tds, net = case @employee.country
                when "India" then [gross * 0.10, gross * 0.90]
                when "United States" then [gross * 0.12, gross * 0.88]
                else [0, gross]
                end

      render json: { employee_id: @employee.id, gross_salary: gross, tds_deduction: tds, net_salary: net }
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end