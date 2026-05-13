<?php

declare(strict_types=1);

require_once __DIR__ . '/../includes/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: ../browse.php');
    exit;
}

$rawId = $_POST['id'] ?? '';
if ($rawId === '' || !ctype_digit((string) $rawId)) {
    header('Location: ../browse.php?err=' . rawurlencode('Invalid car id.'));
    exit;
}

$id = (int) $rawId;
if ($id < 1) {
    header('Location: ../browse.php?err=' . rawurlencode('Invalid car id.'));
    exit;
}

try {
    $pdo = lab5_pdo();
    $stmt = $pdo->prepare('DELETE FROM cars WHERE id = ?');
    $stmt->execute([$id]);
    if ($stmt->rowCount() === 0) {
        header('Location: ../browse.php?err=' . rawurlencode('Car was not found or already removed.'));
        exit;
    }
    header('Location: ../browse.php?ok=' . rawurlencode('Car removed.'));
    exit;
} catch (Throwable $e) {
    header('Location: ../browse.php?err=' . rawurlencode('Database error.'));
    exit;
}
