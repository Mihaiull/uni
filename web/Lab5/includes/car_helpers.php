<?php

declare(strict_types=1);

// db.php must be loaded first by the caller (browse.php, add.php, edit.php).

const LAB5_FUEL_LABELS = [
    'petrol' => 'Petrol',
    'diesel' => 'Diesel',
    'electric' => 'Electric',
    'hybrid' => 'Hybrid',
    'lpg' => 'LPG',
    'other' => 'Other',
];

/**
 * @return array<int, array{id:int,name:string}>
 */
function lab5_fetch_categories(PDO $pdo): array
{
    $stmt = $pdo->query('SELECT id, name FROM categories ORDER BY name ASC');
    return $stmt->fetchAll();
}
