require 'rails_helper'

RSpec.describe "Salary Metrics API", type: :request do
  before do
    Employee.create!(full_name: "Deepa", job_title: "Engineer", country: "India", salary: 50000)
    Employee.create!(full_name: "Raj", job_title: "Engineer", country: "India", salary: 70000)
    Employee.create!(full_name: "John", job_title: "Manager", country: "United States", salary: 90000)
    Employee.create!(full_name: "Marie", job_title: "Engineer", country: "France", salary: 60000)
  end

  describe "GET /salary/metrics?country=India" do
    it "returns min, max and average salary for India" do
      get "/salary/metrics", params: { country: "India" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["minimum_salary"]).to eq("50000.0")
      expect(body["maximum_salary"]).to eq("70000.0")
      expect(body["average_salary"]).to eq("60000.0")
    end
  end

  describe "GET /salary/metrics?job_title=Engineer" do
    it "returns average salary for Engineer" do
      get "/salary/metrics", params: { job_title: "Engineer" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["average_salary"]).to eq("60000.0")
    end
  end

  describe "Edge cases" do
    it "returns error when no params given" do
      get "/salary/metrics"
      expect(response).to have_http_status(:bad_request)
    end

    it "returns null when country has no employees" do
      get "/salary/metrics", params: { country: "Australia" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["minimum_salary"]).to be_nil
    end
  end
end