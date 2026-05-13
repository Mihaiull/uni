<?php

declare(strict_types=1);

/**
 * @return PDO
 */
function lab5_mysql_pdo_from_config(array $cfg): PDO
{
    foreach (['db_host', 'db_name', 'db_user', 'db_pass'] as $key) {
        if (!isset($cfg[$key]) || !is_string($cfg[$key]) || $cfg[$key] === '') {
            throw new RuntimeException('Invalid database configuration: missing ' . $key);
        }
    }

    $dbname = $cfg['db_name'];
    $socket = isset($cfg['unix_socket']) && is_string($cfg['unix_socket']) && $cfg['unix_socket'] !== ''
        ? $cfg['unix_socket']
        : null;

    if ($socket !== null) {
        $dsn = sprintf(
            'mysql:unix_socket=%s;dbname=%s;charset=utf8mb4',
            $socket,
            $dbname
        );
    } else {
        $host = $cfg['db_host'];
        $port = isset($cfg['db_port']) && is_numeric($cfg['db_port']) ? (int) $cfg['db_port'] : 0;
        if ($port > 0) {
            $dsn = sprintf(
                'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
                $host,
                $port,
                $dbname
            );
        } else {
            $dsn = sprintf(
                'mysql:host=%s;dbname=%s;charset=utf8mb4',
                $host,
                $dbname
            );
        }
    }

    return new PDO($dsn, $cfg['db_user'], $cfg['db_pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
}

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
    $driver = ($cfg['driver'] ?? 'sqlite') === 'mysql' ? 'mysql' : 'sqlite';

    if ($driver === 'sqlite') {
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
    } else {
        if (!in_array('mysql', PDO::getAvailableDrivers(), true)) {
            throw new RuntimeException('pdo_mysql is not available.');
        }
        $pdo = lab5_mysql_pdo_from_config($cfg);
    }

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
