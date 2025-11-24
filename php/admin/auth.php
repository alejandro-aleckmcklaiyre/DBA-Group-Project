<?php
// php/admin/auth.php
// Example API endpoint that delegates to AuthController. POST /php/admin/auth.php

require_once __DIR__ . '/../bootstrap.php';
require_once __DIR__ . '/../controllers/AuthController.php';

$controller = new AuthController($pdo);

$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'POST') {
    $input = json_input();
    if ($input === null) {
        http_response_code(400);
        echo json_encode(['message' => 'Invalid JSON']);
        exit;
    }

    $result = $controller->login($input);
    echo json_encode($result);
    exit;
}

// Only POST supported for this endpoint
http_response_code(405);
echo json_encode(['message' => 'Method not allowed']);
exit;
