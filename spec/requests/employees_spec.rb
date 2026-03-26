require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  describe "POST /employees" do
    context "with valid params" do
      it "creates an employee" do
        post '/employees', params: { employee: { full_name: "Deepa Verma", job_title: "Engineer", country: "India", salary: 50000 } }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["full_name"]).to eq("Deepa Verma")
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post '/employees', params: { employee: { full_name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /employees" do
    it "returns all employees" do
      Employee.create!(full_name: "Deepa", job_title: "Engineer", country: "India", salary: 50000)
      get '/employees'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "GET /employees/:id" do
    it "returns a single employee" do
      emp = Employee.create!(full_name: "Deepa", job_title: "Engineer", country: "India", salary: 50000)
      get "/employees/#{emp.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /employees/:id" do
    it "updates an employee" do
      emp = Employee.create!(full_name: "Deepa", job_title: "Engineer", country: "India", salary: 50000)
      put "/employees/#{emp.id}", params: { employee: { full_name: "Deepa Verma" } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["full_name"]).to eq("Deepa Verma")
    end
  end

  describe "DELETE /employees/:id" do
    it "deletes an employee" do
      emp = Employee.create!(full_name: "Deepa", job_title: "Engineer", country: "India", salary: 50000)
      delete "/employees/#{emp.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
