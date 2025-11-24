<?php
// php/migrations/seed_user.php
// Run from CLI: php seed_user.php --email=admin@example.com --password=secret --role=admin

require_once __DIR__ . '/../bootstrap.php';

$options = getopt('', ['email:', 'password:', 'role::']);
if (!isset($options['email']) || !isset($options['password'])) {
    echo "Usage: php seed_user.php --email=you@example.com --password=secret [--role=admin]\n";
    exit(1);
}

$email = $options['email'];
$pass = $options['password'];
$role = $options['role'] ?? 'admin';

try {
    $stmt = $pdo->prepare('INSERT INTO users (email, password_hash, role, created_at) VALUES (:email, :hash, :role, NOW())');
    $hash = password_hash($pass, PASSWORD_DEFAULT);
    $stmt->execute([':email' => $email, ':hash' => $hash, ':role' => $role]);
    echo "User created with ID: " . $pdo->lastInsertId() . "\n";
} catch (PDOException $e) {
    echo "Failed to insert user: " . $e->getMessage() . "\n";
}
