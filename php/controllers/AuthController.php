<?php
// php/controllers/AuthController.php
// Controller for authentication-related actions. Uses User model (PDO) and returns JSON responses.

require_once __DIR__ . '/../models/User.php';

class AuthController {
    protected $pdo;
    protected $userModel;

    public function __construct(PDO $pdo) {
        $this->pdo = $pdo;
        $this->userModel = new User($pdo);
    }

    // Handle login request. Expects JSON: { email, password }
    public function login($input) {
        if (!isset($input['email']) || !isset($input['password'])) {
            http_response_code(422);
            return ['message' => 'Email and password are required.'];
        }

        $email = trim($input['email']);
        $password = $input['password'];

        $user = $this->userModel->verifyCredentials($email, $password);
        if (!$user) {
            http_response_code(401);
            return ['message' => 'Invalid credentials.'];
        }

        // For demo: generate a simple token (in production use JWT or server session)
        $token = bin2hex(random_bytes(16));

        // Store token in a simple tokens table or server session. For now, return token and user info.
        return ['success' => true, 'token' => $token, 'user' => $user];
    }

    // Additional endpoints (register, logout) can be added here.
}
