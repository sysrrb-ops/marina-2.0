-- Marina Valérielle Luxury Yacht Charters Database Dump
-- Compatible with MySQL 8.0+ and PostgreSQL

CREATE TABLE IF NOT EXISTS customers (
  customer_id VARCHAR(20) PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  country VARCHAR(50) DEFAULT 'Thailand',
  membership_tier VARCHAR(20) DEFAULT 'Pearl'
);

CREATE TABLE IF NOT EXISTS yachts (
  yacht_id VARCHAR(20) PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  model VARCHAR(100) NOT NULL,
  length_ft INT NOT NULL,
  max_capacity INT NOT NULL,
  status VARCHAR(20) DEFAULT 'Ready'
);

CREATE TABLE IF NOT EXISTS packages (
  package_id VARCHAR(20) PRIMARY KEY,
  package_name VARCHAR(100) NOT NULL,
  duration_hours VARCHAR(30) NOT NULL,
  max_guests INT NOT NULL,
  base_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS bookings (
  booking_id VARCHAR(20) PRIMARY KEY,
  customer_id VARCHAR(20) REFERENCES customers(customer_id),
  package_id VARCHAR(20) REFERENCES packages(package_id),
  charter_date DATE NOT NULL,
  guest_count INT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  booking_status VARCHAR(20) DEFAULT 'Confirmed'
);

CREATE TABLE IF NOT EXISTS services (
  service_id VARCHAR(20) PRIMARY KEY,
  service_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  base_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS booking_services (
  id SERIAL PRIMARY KEY,
  booking_id VARCHAR(20) REFERENCES bookings(booking_id),
  service_id VARCHAR(20) REFERENCES services(service_id),
  quantity INT DEFAULT 1,
  subtotal DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS promotions (
  promo_code VARCHAR(20) PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  discount_pct INT NOT NULL,
  expiry_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS memberships (
  tier_id VARCHAR(20) PRIMARY KEY,
  tier_name VARCHAR(50) NOT NULL,
  min_trips INT DEFAULT 0,
  discount_addons_pct INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS payments (
  payment_id VARCHAR(20) PRIMARY KEY,
  booking_id VARCHAR(20) REFERENCES bookings(booking_id),
  payment_method VARCHAR(50) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payment_status VARCHAR(20) DEFAULT 'Paid'
);

-- Seed Data
INSERT INTO packages VALUES 
('PKG-01', 'Azure Escape', '4 ชม.', 6, 18900.00),
('PKG-02', 'Azure Romance', '5 ชม.', 2, 29900.00),
('PKG-03', 'Valérielle Family Voyage', '6-8 ชม.', 8, 39900.00),
('PKG-04', 'Prestige Island Retreat', '8 ชม.', 8, 69900.00),
('PKG-05', 'Blue Horizon Corporate', '6-8 ชม.', 12, 59900.00);
