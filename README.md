# **Bookstore Management System**

## **Overview**

The **Bookstore Management System** is a scalable and secure web application for managing bookstores, books, and customer orders. This project demonstrates advanced Ruby on Rails development with features such as role-based authentication, RESTful API integration, background jobs, and reporting dashboards. 

### **Key Features**
- **Role-Based Authentication**:  
  Implements `Devise` for secure user authentication, supporting the roles:  
  - **Admin**: Full access (manage users, bookstores, books, and reports).
  - **Manager**: Limited to managing assigned bookstores and related books.
  - **Customer**: Can browse books and manage orders.
  
- **RESTful API with Grape**:  
  APIs are built using **Grape**, a lightweight framework on top of Rack. It also generates **Swagger API documentation** for easy integration.

- **Background Jobs**:  
  Background tasks are handled by **Sidekiq**, including generating monthly sales reports.

- **Search and Filtering**:  
  Flexible search and filtering of bookstores and books using **Ransack**.

- **Admin Dashboard**:  
  Displays key metrics like revenue trends, bookstore performance, and total counts.

---

## **Setup Instructions**

### **Requirements**
- **Ruby Version**: 2.3  
- **Rails Version**: 4.2  
- **Database**: PostgreSQL  
- **Redis**: For Sidekiq job processing  
- **Grape**: For APIs  
- **Sidekiq**: For background job handling  

### **Installation**

#### **1. Clone the Repository**
```bash
git clone <repository_url>
cd bookstore_management_system
```

#### **2. Install Dependencies**
```bash
bundle install
```

#### **3. Setup Environment Variables**
Create a `.env` file in the project root with the following content:
```env
EMAIL_USERNAME=your_email@example.com
EMAIL_PASSWORD=your_password
SENDGRID_USERNAME=your_sendgrid_username
SENDGRID_API_KEY=your_sendgrid_api_key
REDIS_URL=redis://localhost:6379/0
```

#### **4. Setup the Database**
```bash
rake db:create
rake db:migrate
rake db:seed
```
The `seed.rb` file initializes default roles:
- **Admin**: `admin@example.com`
- **Manager**: `manager1@example.com`, `manager2@example.com`
- **Customer**: `customer1@example.com`, `customer2@example.com`

#### **5. Start Redis and Sidekiq**
- Start Redis:
  ```bash
  redis-server
  ```
- Start Sidekiq:
  ```bash
  bundle exec sidekiq
  ```

#### **6. Start the Rails Server**
```bash
rails server
```

#### **7. Access the Application**
Visit: [http://localhost:3000](http://localhost:3000)

---

## **API Documentation**

### **Grape API**
- Built with **Grape** for RESTful design on top of Rack.
- Exposes bookstore and book endpoints.
- Secured with JWT-based authentication.

### **Swagger Documentation**
- Swagger documentation for API endpoints is auto-generated.  
  Access it at: [http://localhost:3000/swagger](http://localhost:3000/swagger)

### **API Authentication**
Use the `Authorization` header with a valid JWT token:
```http
Authorization: Bearer <JWT_TOKEN>
```

---

## **Architecture**

### **1. Models**
- **User**: Manages roles (`Admin`, `Manager`, `Customer`).
- **Bookstore**: Represents bookstores, optionally assigned to a manager.
- **Book**: Tracks bookstore-specific inventory.
- **Order**: Records customer purchases.
- **JwtDenylist**: Revoked JWT tokens for API security.

### **2. Services**
- **Order Generation**: Assumes a separate service to handle order creation and validations.
- **DashboardService**: Generates metrics for the admin dashboard.

### **3. Controllers**
- **Admin::UsersController**: Manages users (create, assign roles, edit).
- **BooksController**: Handles book CRUD operations.
- **BookstoresController**: Manages bookstores and assigns managers.
- **API::Base**: Modular Grape-based API architecture.
- **Customer::DashboardController**: Displays customer orders.
- **Manager::DashboardController**: Provides performance data for managed bookstores.

### **4. Background Jobs**
- **GenerateMonthlySalesReportJob**:  
  - Queries sales data for the previous month.
  - Sends detailed reports to bookstore managers via `ReportMailer`.

### **5. Views**
- Partial views for reusability (e.g., form components).
- Custom dashboards for each role.

---

## **Role-Based Features**

| **Role**    | **Permissions**                                                                 |
|-------------|---------------------------------------------------------------------------------|
| **Admin**   | Full control over users, bookstores, books, and reports.                        |
| **Manager** | Can manage assigned bookstores and related books.                               |
| **Customer**| Can browse books and place orders.                                              |

---

## **Cron Jobs**
- Configured with `whenever` for generating monthly sales reports.  
- To update cron jobs:
  ```bash
  whenever --update-crontab
  ```
- Logs can be checked in: `log/cron.log`

---

## **Assumptions**
1. **Order Generation**:  
   Orders are handled by a separate service to streamline operations and enforce business logic.
   
2. **Database Initialization**:  
   The `seed.rb` file populates the database with:
   - Admin, Manager, and Customer roles.
   - Sample bookstores, books, and orders.

3. **Background Jobs**:  
   Sidekiq is assumed to be running alongside the Redis server.

---

## **Testing**

### **Run RSpec Tests**
```bash
bundle exec rspec
```

### **Run Rails Tests**
```bash
rake test
```

---

## **Future Enhancements**
- Add Elasticsearch for optimized search over large datasets.
- Enable real-time notifications for customers and managers.
- Integrate payment gateways for online book purchases.

---