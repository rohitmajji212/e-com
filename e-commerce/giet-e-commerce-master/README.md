# E-Commerce Servlet Application

A complete e-commerce web application built with Java Servlets, JSP, HTML, CSS, and MySQL database.

## Quick Start (Windows)

Follow these steps to run the project locally.

### Prerequisites
- JDK 11 or higher (set JAVA_HOME)
- Maven 3.6+ in PATH
- MySQL 8.0+ running locally (or compatible MySQL server)

### 1) Database setup
1. Create a MySQL database named `ecommerce` (or choose your own name).
2. Create a MySQL user with privileges or use an existing one.
3. Update the credentials in `src/main/java/com/ecommerce/util/DatabaseConnection.java`:
   - URL (default in repo): `jdbc:mysql://localhost:3306/ecommerce`
   - USERNAME
   - PASSWORD

If you want to keep credentials out of source code, consider changing DatabaseConnection to read from env vars, but the current code uses constants.

Tables expected by the app include: users, products, cart_items (and others used by DAOs/JSPs). If you don't have a schema yet, you can create minimal tables to get the product list and cart working. Example minimal schema:

```sql
CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  user_type VARCHAR(20) NOT NULL DEFAULT 'customer'
);

CREATE TABLE IF NOT EXISTS products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  image_url VARCHAR(500),
  stock_quantity INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS cart_items (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

Optional: seed some products for testing.

```sql
INSERT INTO products (product_name, price, image_url, stock_quantity, is_active) VALUES
('Sample Product 1', 19.99, NULL, 100, 1),
('Sample Product 2', 49.99, NULL, 50, 1);
```

### 2) Run the app (embedded Tomcat via Maven)
This project is packaged as a WAR and already includes the Tomcat 7 Maven plugin for development.

- In a terminal (PowerShell) at the project root, run:

```
mvn clean package
mvn tomcat7:run
```

- The app will start at: http://localhost:8080/ecommerce

### 3) Access URLs
- Product catalog: http://localhost:8080/ecommerce/products
- Login: http://localhost:8080/ecommerce/login
- Cart: http://localhost:8080/ecommerce/cart

Note: The welcome file points to `products`, so visiting http://localhost:8080/ecommerce should redirect/render products.

### Alternative: Deploy WAR to a standalone Tomcat
1. Build the WAR:
```
mvn clean package
```
2. Copy `target/ecommerce-app.war` to your Tomcat `webapps` folder.
3. Start Tomcat and access at `http://localhost:8080/ecommerce-app` (context may differ by filename).

## Troubleshooting
- Port 8080 is busy: change the port in `pom.xml` under `tomcat7-maven-plugin`.
- DB connection errors: verify MySQL is running, credentials in `DatabaseConnection.java`, and the schema exists.
- JDBC driver errors: Maven will download `mysql-connector-java` automatically; ensure you ran `mvn package` at least once.

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/ecommerce/
│   │       ├── dao/          # Data Access Objects
│   │       ├── model/        # Entity classes
│   │       ├── servlet/      # Servlet controllers
│   │       └── util/         # Utility classes
│   ├── webapp/
│   │   ├── WEB-INF/
│   │   │   ├── views/        # JSP pages
│   │   │   └── web.xml       # Web application configuration
│   │   ├── css/              # CSS stylesheets
│   │   └── images/           # Static images
│   └── resources/            # Configuration files
```

## Development
To run in development mode with embedded Tomcat:

```
mvn tomcat7:run
```

This will start the application on `http://localhost:8080/ecommerce`.

## License
This project is licensed under the MIT License.