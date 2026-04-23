

CREATE DATABASE IF NOT EXISTS salon_booking
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE salon_booking;

CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(32),
  profile_image VARCHAR(255) NULL,
  password_hash VARCHAR(255) NOT NULL,
  date_of_birth DATE NULL,
  status ENUM('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
  membership_level VARCHAR(64) NULL,
  member_since_year SMALLINT NULL,
  preferred_services TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- If tables were already created earlier, make sure required columns exist
ALTER TABLE users ADD COLUMN IF NOT EXISTS profile_image VARCHAR(255) NULL;

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS profile_image VARCHAR(255) NULL;

CREATE TABLE IF NOT EXISTS services (
  service_id INT AUTO_INCREMENT PRIMARY KEY,
  service_name VARCHAR(160) NOT NULL,
  description TEXT,
  category VARCHAR(80) NOT NULL,
  stylist_name VARCHAR(120) NOT NULL,
  service_code VARCHAR(40) NOT NULL UNIQUE,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  duration_minutes INT NOT NULL DEFAULT 60,
  is_active TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS bookings (
  booking_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  service_id INT NOT NULL,
  appointment_datetime DATETIME NOT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'CONFIRMED',
  notes VARCHAR(255) NULL,
  CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_booking_service FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE RESTRICT,
  INDEX idx_bookings_user (user_id),
  INDEX idx_bookings_appt (appointment_datetime)
);

CREATE TABLE IF NOT EXISTS apply_requests (
  request_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  service_id INT NOT NULL,
  preferred_date DATE NULL,
  message VARCHAR(600) NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'PENDING',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_apply_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_apply_service FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE,
  INDEX idx_apply_user (user_id)
);

-- Demo user: email demo@salon.com  password: password
INSERT INTO users (full_name, email, phone, password_hash, date_of_birth, status, membership_level, member_since_year, preferred_services, profile_image)
VALUES
('Demo Client', 'demo@salon.com', '07700123456',
 '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
 '1998-05-12', 'APPROVED', 'Standard', 2024, 'Hair colour, nails', NULL)
ON DUPLICATE KEY UPDATE email = email;

INSERT INTO services (service_name, description, category, stylist_name, service_code, price, duration_minutes)
VALUES
('Balayage', 'Hand-painted highlights', 'Hair colour', 'Priya Sharma', '100', 85.00, 120),
('Classic Manicure', 'Shape, cuticle care, polish', 'Nails', 'Alex Kim', '101', 35.00, 45),
('Deep Conditioning', 'Repair treatment', 'Hair care', 'Priya Sharma', '102', 45.00, 60),
('Bridal Trial', 'Full hair and makeup trial', 'Bridal', 'Maya Patel', '103', 120.00, 150),
('Soft Glam Makeup', 'Party-ready soft glam look', 'Makeup', 'Maya Patel', '104', 65.00, 75),
('HD Makeup', 'High-definition makeup for photos', 'Makeup', 'Nisha Rai', '105', 90.00, 90),
('Keratin Smooth', 'Frizz control and smoothing treatment', 'Hair care', 'Priya Sharma', '106', 110.00, 140),
('Layer Cut + Styling', 'Layer haircut with blow dry styling', 'Hair care', 'Rina Joshi', '107', 38.00, 55),
('Global Hair Color', 'Single-tone full hair coloring', 'Hair colour', 'Rina Joshi', '108', 95.00, 130),
('Gel Nail Extensions', 'Full set gel extensions', 'Nails', 'Alex Kim', '109', 70.00, 90),
('Nail Art Premium', 'Creative custom nail art design', 'Nails', 'Sita Karki', '110', 55.00, 75)
ON DUPLICATE KEY UPDATE service_code = service_code;

-- One sample booking for the demo user (so the dashboard shows data). Safe to run once.
INSERT INTO bookings (user_id, service_id, appointment_datetime, status, notes)
SELECT u.user_id, s.service_id, DATE_ADD(NOW(), INTERVAL 7 DAY), 'CONFIRMED', 'Sample booking'
FROM users u, services s
WHERE u.email = 'demo@salon.com' AND s.service_code = '100'
AND NOT EXISTS (
  SELECT 1 FROM bookings b WHERE b.user_id = u.user_id AND b.service_id = s.service_id
);
