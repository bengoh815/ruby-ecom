# E-commerce Web Application with Real-Time Order Tracking

### Project Overview

This project is an e-commerce platform built using Ruby on Rails with real-time order tracking. It integrates several AWS services to offer cloud-based scalability and security while keeping the project affordable. The project focuses on showcasing important skills like cloud deployment, user management, and payment integration.

### Key Features

1. User Authentication & Authorization

   - Implement user roles (e.g., Admin, Customer) using Devise or similar.
   - Use AWS Cognito or OAuth for secure customer logins.

2. Product Management

   - Admins can manage products (add, edit, delete) with image uploads stored in AWS S3.

3. Order Management

   - Customers can browse products, add items to a cart, and place orders.
   - Order data is managed using PostgreSQL or MySQL hosted on AWS RDS or an EC2 instance.

4. Real-Time Order Tracking

- Real-time tracking of orders using AWS Lambda and SNS.
- Customers receive notifications when their orders are updated (e.g., received, shipped, delivered).

5. Payment Integration

- Seamless transactions with Stripe or PayPal.
- Transaction history is stored securely, using AWS DynamoDB or an EC2-based database.

6. Analytics Dashboard

- Admin dashboard built with AWS QuickSight for tracking sales, customer behavior, and product trends.

7. Search Functionality

- Fast product search using AWS Elasticsearch or an open-source alternative like MeiliSearch.

8. Scalability & Security

- Deployed on AWS Elastic Beanstalk or EC2 with load balancing and auto-scaling.
- Secure transactions using AWS WAF and permissions managed with AWS IAM.

### Learning Outcomes

- Ruby on Rails: Gain in-depth experience building a full-stack web application.
- AWS Services: Understand the use of cloud services like AWS S3, Lambda, RDS, and more.
- Scalability & Security: Learn best practices for scaling and securing a cloud-based application.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/ecommerce-app.git
   cd ecommerce-app
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the server:
   ```bash
   rails server
   ```
   Visit http://localhost:3000 in your browser.

### Deployment

This application can be deployed on AWS EC2 or AWS Elastic Beanstalk. Follow these steps for deployment:

1. Set up an EC2 instance or Elastic Beanstalk environment.

2. Configure AWS S3 for media storage and PostgreSQL for your database.

3. Use AWS Lambda for real-time order status updates, and SNS for customer notifications.

### License

This project is licensed under the MIT License.
