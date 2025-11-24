<?php
// php/admin/ping.php
// Simple endpoint to verify reachability and allowed methods (GET/POST/OPTIONS).
require_once __DIR__ . '/../bootstrap.php';

if (PHP_SAPI === 'cli') {
    echo json_encode(['error' => 'ping.php should be accessed via HTTP']);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
if ($method === 'OPTIONS') {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, X-Requested-With');
    http_response_code(204);
    exit;
}

header('Content-Type: application/json; charset=utf-8');

$body = json_input();
$headers = function_exists('getallheaders') ? getallheaders() : [];

echo json_encode([
    'ok' => true,
    'method' => $method,
    'headers' => $headers,
    'body' => $body,
    'message' => 'ping response from php/admin/ping.php'
]);
exit;
