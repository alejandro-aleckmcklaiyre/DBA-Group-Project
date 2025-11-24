PHP API folder
===============

This folder contains a minimal, PDO-based API structure designed to be easy to migrate to Laravel controllers later.

Structure
- `config.php` — local DB settings (update for your XAMPP environment)
- `bootstrap.php` — PDO bootstrap, JSON input helper, and CORS headers for dev
- `models/User.php` — simple User model using prepared statements
- `controllers/AuthController.php` — authentication controller, returns JSON
- `admin/auth.php` — example endpoint: POST to login
- `migrations/create_users.sql` — SQL to create a `users` table
- `migrations/seed_user.php` — PHP script to insert a user (hashes password)

Notes / Security
- This code uses PDO prepared statements (no concatenated SQL), and `password_hash` for passwords.
- For production, do NOT use `Access-Control-Allow-Origin: *` — configure CORS and use HTTPS.
- Prefer server-side session or JWT stored in secure, HttpOnly cookies instead of localStorage.

How to setup locally (XAMPP)
1. Import `php/migrations/create_users.sql` into your `db_hris` database (via phpMyAdmin or CLI).
2. From project root, run the seed script to create an admin user:

   php php/migrations/seed_user.php --email=admin@example.com --password=YourPass123 --role=admin

3. Test login endpoint using curl or Postman:

   curl -X POST http://localhost/path/to/project/php/admin/auth.php \
     -H "Content-Type: application/json" \
     -d '{"email":"admin@example.com","password":"YourPass123"}'

Laravel migration hints
- Move controllers into `app/Http/Controllers`, models into `app/Models` and use Eloquent.
- Register API routes in `routes/api.php` and use `Auth::attempt()` for session-based login.

to test 
email: admin@example.com 
password: YourPass123 
role: admin