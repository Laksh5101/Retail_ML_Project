-- Retail Analytics schema
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  signup_date TIMESTAMP,
  region VARCHAR(50),
  channel VARCHAR(50),
  segment VARCHAR(50),
  age INT,
  last_purchase_date TIMESTAMP,
  days_since_last_purchase INT,
  churned INT
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  sku VARCHAR(50),
  category VARCHAR(50),
  subcategory VARCHAR(50),
  unit_price DECIMAL(10,2)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date TIMESTAMP,
  channel_type VARCHAR(50),
  payment_method VARCHAR(50)
);

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  product_id INT REFERENCES products(product_id),
  quantity INT,
  unit_price DECIMAL(10,2),
  discount_rate DECIMAL(5,2)
);

CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_products_category ON products(category);