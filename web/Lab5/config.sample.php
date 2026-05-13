<?php
/**
 * Local development (default): SQLite file — no server, no remote access.
 * Tables are created automatically on first request.
 */
return [
    'driver' => 'sqlite',
    'sqlite_path' => __DIR__ . '/data/lab5.sqlite',
];
