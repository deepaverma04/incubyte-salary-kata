# 💼 Incubyte Salary Management API

A production-ready RESTful API built using Ruby on Rails (API mode) to manage employee data and provide salary insights.

This project follows **Test-Driven Development (TDD)** and clean architecture principles, ensuring maintainable and scalable code.

---

## 🚀 Features

### ✅ Employee CRUD

* Create, Read, Update, Delete employees
* Validations for required fields

### ✅ Salary Calculation

Calculate deductions and net salary based on country:

| Country       | TDS |
| ------------- | --- |
| India         | 10% |
| United States | 12% |
| Others        | 0%  |

### ✅ Salary Metrics

* Min, max, average salary by country
* Average salary by job title
* Handles edge cases (no data, missing params)

---

## 🛠 Tech Stack

* Ruby 3.x
* Rails 8 (API mode)
* SQLite
* RSpec
* SimpleCov

---

## ⚙️ Setup
```bash
git clone <repo_url>
cd incubyte-salary-kata

bundle install
rails db:create db:migrate

# Run tests
bundle exec rspec

# Start server
rails server
```

---

## 📌 API Endpoints

### Employees

| Method     | Endpoint          | Description |
| ---------- | ----------------- | ----------- |
| POST       | /employees        | Create      |
| GET        | /employees        | List all    |
| GET        | /employees/:id    | Show one    |
| PATCH/PUT  | /employees/:id    | Update      |
| DELETE     | /employees/:id    | Delete      |
| GET        | /employees/:id/salary | Salary calculation |

---

### Salary Calculation
```
GET /employees/:id/salary
```

**Response**
```json
{
  "employee_id": 1,
  "gross_salary": 50000.0,
  "tds_deduction": 5000.0,
  "net_salary": 45000.0
}
```

---

### Salary Metrics

**By Country**
```
GET /salary/metrics?country=India
```

**Response**
```json
{
  "minimum_salary": "50000.0",
  "maximum_salary": "70000.0",
  "average_salary": "60000.0"
}
```

**By Job Title**
```
GET /salary/metrics?job_title=Engineer
```

**Response**
```json
{
  "average_salary": "60000.0"
}
```

---

## 🧪 Testing (TDD)

* Followed strict TDD cycle: **Red → Green → Refactor**
* Request specs for all endpoints
* Edge cases covered (missing params, no data, invalid ID)
* Used SimpleCov for coverage

---

## 🧱 Architecture

* Used **Service Object Pattern** (`SalaryMetricsService`)
* Controllers are kept thin
* Business logic separated for better maintainability

---

## 🤖 AI Usage

**Tool used:** Claude (Anthropic)

**Prompts used for:**
- Generating RSpec edge case scenarios for metrics endpoint
- Reviewing controller and service code for production readiness
- Drafting README structure

**Manually written:**
- All business logic (deduction rules, metrics queries)
- TDD commit flow and test structure
- Final code review and validation of all AI suggestions

---

## 🙌 Author

Deepa VermaP