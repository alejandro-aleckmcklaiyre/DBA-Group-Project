<?php
// php/bootstrap.php
// PDO bootstrap and helper loader. Uses prepared statements and exceptions.

$config = require __DIR__ . '/config.php';
$db = $config['db'];
// Use configured port if provided (useful for XAMPP setups using 3307)
$host = $db['host'] ?? '127.0.0.1';
$port = isset($db['port']) ? $db['port'] : 3306;
$dsn = "mysql:host={$host};port={$port};dbname={$db['dbname']};charset={$db['charset']}";

try {
    $pdo = new PDO($dsn, $db['user'], $db['pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Database connection failed', 'details' => $e->getMessage()]);
    exit;
}

// Simple helper to read JSON body
function json_input() {
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    if (json_last_error() !== JSON_ERROR_NONE) return null;
    return $data;
}

// CORS and preflight for local dev (adjust in production)
// When running from CLI (seed scripts), do not emit HTTP headers or rely on $_SERVER['REQUEST_METHOD']
if (PHP_SAPI !== 'cli') {
    if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
        header('Access-Control-Allow-Headers: Content-Type, X-Requested-With, X-CSRF-TOKEN');
        exit;
    }
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json; charset=utf-8');
}
