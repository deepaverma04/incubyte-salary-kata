require 'rails_helper'

RSpec.describe "Salary Calculation API", type: :request do
  let(:india_employee) { Employee.create!(full_name: "Deepa", job_title: "Engineer", country: "India", salary: 50000) }
  let(:us_employee) { Employee.create!(full_name: "John", job_title: "Engineer", country: "United States", salary: 50000) }
  let(:other_employee) { Employee.create!(full_name: "Marie", job_title: "Engineer", country: "France", salary: 50000) }

  describe "GET /employees/:id/salary" do
    context "India employee" do
      it "deducts 10% TDS" do
        get "/employees/#{india_employee.id}/salary"
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["tds_deduction"]).to eq("5000.0")
        expect(body["net_salary"]).to eq("45000.0")
      end
    end

    context "United States employee" do
      it "deducts 12% TDS" do
        get "/employees/#{us_employee.id}/salary"
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["tds_deduction"]).to eq("6000.0")
        expect(body["net_salary"]).to eq("44000.0")
      end
    end

    context "Other country employee" do
      it "no deductions" do
        get "/employees/#{other_employee.id}/salary"
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["tds_deduction"]).to eq(0)
        expect(body["net_salary"]).to eq("50000.0")
      end
    end
  end
end