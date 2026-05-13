<?php

declare(strict_types=1);

/**
 * Create tables and seed categories when using SQLite (first run or empty DB).
 */
function lab5_sqlite_ensure_schema(PDO $pdo): void
{
    $n = (int) $pdo->query(
        "SELECT COUNT(*) FROM sqlite_master WHERE type = 'table' AND name = 'cars'"
    )->fetchColumn();
    if ($n > 0) {
        return;
    }

    $pdo->exec(
        'CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT NOT NULL UNIQUE
        )'
    );

    $pdo->exec(
        'CREATE TABLE cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            category_id INTEGER NOT NULL REFERENCES categories (id) ON UPDATE CASCADE ON DELETE RESTRICT,
            model TEXT NOT NULL,
            engine_power INTEGER NOT NULL,
            fuel TEXT NOT NULL,
            price NUMERIC NOT NULL,
            color TEXT NOT NULL,
            age_years INTEGER NOT NULL,
            history TEXT,
            created_at TEXT NOT NULL DEFAULT (datetime(\'now\'))
        )'
    );

    $pdo->exec('CREATE INDEX idx_cars_category ON cars (category_id)');

    $stmt = $pdo->prepare('INSERT INTO categories (id, name) VALUES (?, ?)');
    $seed = [
        [1, 'Sedan'],
        [2, 'SUV'],
        [3, 'Hatchback'],
        [4, 'Coupe'],
        [5, 'Van / MPV'],
        [6, 'Other'],
    ];
    foreach ($seed as [$id, $name]) {
        $stmt->execute([$id, $name]);
    }
}
