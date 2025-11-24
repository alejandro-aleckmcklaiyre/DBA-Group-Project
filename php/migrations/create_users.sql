-- migrations/create_users.sql
-- Run this SQL to create a minimal `users` table used by the PHP endpoints.
-- Note: For security, passwords are stored hashed; use the provided seed script to create users with hashed passwords.

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(191) NOT NULL UNIQUE,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'applicant',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- NOTE: To insert a seeded admin user with a hashed password, run the seed script:
-- php migrations/seed_user.php --email=admin@example.com --password=ChangeMe123 --role=admin
