<?php

declare(strict_types=1);

require_once __DIR__ . '/../includes/db.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
    exit;
}

$rawId = $_GET['category_id'] ?? '';
if ($rawId === '' || !ctype_digit((string) $rawId)) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid category_id']);
    exit;
}

$categoryId = (int) $rawId;
if ($categoryId < 1) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid category_id']);
    exit;
}

try {
    $pdo = lab5_pdo();

    $stmtCat = $pdo->prepare('SELECT id, name FROM categories WHERE id = ? LIMIT 1');
    $stmtCat->execute([$categoryId]);
    $category = $stmtCat->fetch();
    if (!$category) {
        http_response_code(404);
        echo json_encode(['ok' => false, 'error' => 'Category not found']);
        exit;
    }

    $stmt = $pdo->prepare(
        'SELECT c.id, c.category_id, c.model, c.engine_power, c.fuel, c.price, c.color, c.age_years, c.history, c.created_at
         FROM cars c
         WHERE c.category_id = ?
         ORDER BY c.model ASC, c.id ASC'
    );
    $stmt->execute([$categoryId]);
    $cars = $stmt->fetchAll();

    echo json_encode([
        'ok' => true,
        'category' => $category,
        'cars' => $cars,
    ], JSON_THROW_ON_ERROR);
} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Database error.']);
}
