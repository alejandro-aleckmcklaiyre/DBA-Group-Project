<?php
// php/models/User.php
// Model for `users` table using PDO prepared statements. Designed to be migration-friendly for Laravel later.

class User {
    protected $pdo;
    public function __construct(PDO $pdo) {
        $this->pdo = $pdo;
    }

    public function findByEmail(string $email) {
        $stmt = $this->pdo->prepare('SELECT id, email, password_hash, role, created_at FROM users WHERE email = :email LIMIT 1');
        $stmt->execute([':email' => $email]);
        return $stmt->fetch();
    }

    public function create(string $email, string $password, string $role = 'applicant') {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $this->pdo->prepare('INSERT INTO users (email, password_hash, role, created_at) VALUES (:email, :hash, :role, NOW())');
        $stmt->execute([':email' => $email, ':hash' => $hash, ':role' => $role]);
        return $this->pdo->lastInsertId();
    }

    // Verify and return user record without password
    public function verifyCredentials(string $email, string $password) {
        $user = $this->findByEmail($email);
        if (!$user) return false;
        if (isset($user['password_hash']) && password_verify($password, $user['password_hash'])) {
            unset($user['password_hash']);
            return $user;
        }
        return false;
    }
}
