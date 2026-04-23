-- Shringar salon booking — MySQL database
--
-- HOW TO IMPORT IN XAMPP (phpMyAdmin):
-- 1) Start Apache + MySQL from XAMPP Control Panel.
-- 2) Open http://localhost/phpmyadmin
-- 3) Click "Import" → Choose this file → Go.
--    (Or copy/paste the SQL into the SQL tab and run.)
--
-- Default XAMPP MySQL user is usually: root with NO password.
-- That matches DBconfig.java in the project (localhost:3306, user root, password "").
-- If you set a MySQL password, change DBconfig.java to match.

CREATE DATABASE IF NOT EXISTS salon_booking_system_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE salon_booking_system_db;

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

CREATE TABLE IF NOT EXISTS contact_messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(32) NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Demo user: email demo@salon.com  password: password
INSERT INTO users (full_name, email, phone, password_hash, date_of_birth, status, membership_level, member_since_year, preferred_services, profile_image)
VALUES
('Demo Client', 'demo@salon.com', '07700123456',
 '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
 '1998-05-12', 'APPROVED', 'Standard', 2024, 'Hair colour, nails', NULL)
ON DUPLICATE KEY UPDATE email = email;

-- Admin user: email admin@shringar.com  password: password
INSERT INTO users (full_name, email, phone, password_hash, date_of_birth, status, membership_level, member_since_year, preferred_services, profile_image)
VALUES
('Shringar Admin', 'admin@shringar.com', '9800000001',
 '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
 '1995-01-01', 'APPROVED', 'Administration', 2024, 'Dashboard management', NULL)
ON DUPLICATE KEY UPDATE email = email;

INSERT INTO services (service_name, description, category, stylist_name, service_code, price, duration_minutes)
VALUES
('Rapid Refresh Haircut', 'A quick haircut to keep your look clean and refreshed.', 'Hair', 'Shringar Hair Team', 'HAIR-REFRESH-01', 1000.00, 45),
('Rose Reinvention Haircut', 'A full style transformation to refresh and redefine your look.', 'Hair', 'Shringar Hair Team', 'HAIR-ROSE-02', 1500.00, 75),
('Long Length Haircut & Style', 'A cut for longer hair, keeping it healthy and looking its best.', 'Hair', 'Shringar Hair Team', 'HAIR-LONG-03', 1700.00, 80),
('Curly Haircut', 'A haircut designed for natural curls and soft movement.', 'Hair', 'Shringar Hair Team', 'HAIR-CURL-04', 1600.00, 70),
('Short Haircut', 'A modern short haircut for a clean and confident style.', 'Hair', 'Shringar Hair Team', 'HAIR-SHORT-05', 1200.00, 50),
('Children''s Haircut', 'A fresh haircut made just for kids.', 'Hair', 'Shringar Hair Team', 'HAIR-KIDS-06', 1000.00, 35),
('Bridal Makeup', 'Long-lasting bridal makeup that enhances natural beauty for the special day.', 'Makeup', 'Shringar Makeup Team', 'MAKEUP-BRIDAL-01', 8000.00, 150),
('Party Glam Makeup', 'A glamorous makeup look with bold eyes and glowing skin.', 'Makeup', 'Shringar Makeup Team', 'MAKEUP-PARTY-02', 3000.00, 90),
('Engagement Makeup', 'Elegant makeup designed to give a glowing engagement look.', 'Makeup', 'Shringar Makeup Team', 'MAKEUP-ENGAGE-03', 5000.00, 120),
('Natural Everyday Makeup', 'Light and breathable makeup for a clean daily look.', 'Makeup', 'Shringar Makeup Team', 'MAKEUP-NATURAL-04', 2000.00, 60),
('HD Makeup', 'High-definition makeup for a smooth, photo-ready finish.', 'Makeup', 'Shringar Makeup Team', 'MAKEUP-HD-05', 4500.00, 100),
('Soft Glam Makeup', 'A fresh soft glam look with natural tones.', 'Makeup', 'Shringar Makeup Team', 'MAKEUP-SOFT-06', 2500.00, 75),
('Gel Polish Nails', 'Glossy gel polish with long-lasting shine.', 'Nail', 'Shringar Nail Team', 'NAIL-GEL-01', 1200.00, 45),
('Nail Art Design', 'Creative nail art designs to complete your look.', 'Nail', 'Shringar Nail Team', 'NAIL-ART-02', 1500.00, 60),
('Acrylic Nail Extensions', 'Durable nail extensions that add length and beauty.', 'Nail', 'Shringar Nail Team', 'NAIL-ACRYLIC-03', 2000.00, 90),
('French Tip Nails', 'Classic white-tip nail styling for a polished finish.', 'Nail', 'Shringar Nail Team', 'NAIL-FRENCH-04', 1300.00, 55),
('Soft Gel / Natural Nude Nails', 'A soft nude nail style with an elegant glossy finish.', 'Nail', 'Shringar Nail Team', 'NAIL-NUDE-05', 1400.00, 60),
('Floral Nail Art Design', 'Delicate floral nail designs for a charming look.', 'Nail', 'Shringar Nail Team', 'NAIL-FLORAL-06', 1800.00, 75)
ON DUPLICATE KEY UPDATE service_code = service_code;

-- One sample booking for the demo user (so the dashboard shows data). Safe to run once.
INSERT INTO bookings (user_id, service_id, appointment_datetime, status, notes)
SELECT u.user_id, s.service_id, DATE_ADD(NOW(), INTERVAL 7 DAY), 'CONFIRMED', 'Sample booking'
FROM users u, services s
WHERE u.email = 'demo@salon.com' AND s.service_code = 'SRV-HC-1001'
AND NOT EXISTS (
  SELECT 1 FROM bookings b WHERE b.user_id = u.user_id AND b.service_id = s.service_id
);
