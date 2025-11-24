<?php
// php/config.php
// Minimal config file for local XAMPP/LAMP development. Update values as needed.

return [
    'db' => [
        // Use your XAMPP database; updated to `db_roc` per project notes.
        'host' => '127.0.0.1',
        // If your MySQL uses a non-standard port (example: 3307), set 'port' => 3307
        'port' => 3307,
        'dbname' => 'db_roc',
        'user' => 'root',
        'pass' => '',
        'charset' => 'utf8mb4',
    ],
    // Adjust this to your environment. In production, use environment variables.
];
