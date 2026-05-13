<?php

declare(strict_types=1);

function lab5_pdo(): PDO
{
    static $pdo = null;
    if ($pdo instanceof PDO) {
        return $pdo;
    }

    $configPath = dirname(__DIR__) . '/config.php';
    if (!is_readable($configPath)) {
        throw new RuntimeException('Missing config.php.');
    }

    /** @var array<string,mixed> $cfg */
    $cfg = require $configPath;

    if (!in_array('sqlite', PDO::getAvailableDrivers(), true)) {
        throw new RuntimeException('pdo_sqlite is not available.');
    }

    $path = isset($cfg['sqlite_path']) && is_string($cfg['sqlite_path']) && $cfg['sqlite_path'] !== ''
        ? $cfg['sqlite_path']
        : dirname(__DIR__) . '/data/lab5.sqlite';

    $dir = dirname($path);
    if (!is_dir($dir)) {
        if (!@mkdir($dir, 0755, true) && !is_dir($dir)) {
            throw new RuntimeException('Cannot create SQLite directory.');
        }
    }

    $pdo = new PDO('sqlite:' . $path, null, null, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
    $pdo->exec('PRAGMA foreign_keys = ON');

    require_once __DIR__ . '/sqlite_install.php';
    lab5_sqlite_ensure_schema($pdo);

    return $pdo;
}

function lab5_db_failure_user_message(): string
{
    return 'Database error.';
}

function lab5_h(?string $s): string
{
    return htmlspecialchars((string) $s, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
