<?php

declare(strict_types=1);

require_once __DIR__ . '/../includes/db.php';

const LAB5_FUELS = ['petrol', 'diesel', 'electric', 'hybrid', 'lpg', 'other'];

/**
 * @return array{ok:bool, errors:array<int,string>, data?:array<string,mixed>}
 */
function lab5_validate_car_input(bool $isUpdate): array
{
    $errors = [];

    $categoryRaw = $_POST['category_id'] ?? '';
    if ($categoryRaw === '' || !ctype_digit((string) $categoryRaw)) {
        $errors[] = 'Category is required.';
    }
    $categoryId = (int) $categoryRaw;

    $model = trim((string) ($_POST['model'] ?? ''));
    if ($model === '' || strlen($model) > 200) {
        $errors[] = 'Model must be between 1 and 200 characters.';
    }

    $engineRaw = $_POST['engine_power'] ?? '';
    if ($engineRaw === '' || !ctype_digit((string) $engineRaw)) {
        $errors[] = 'Engine power (HP) must be a whole number.';
    }
    $engine = (int) $engineRaw;
    if ($engine < 1 || $engine > 2000) {
        $errors[] = 'Engine power must be between 1 and 2000 HP.';
    }

    $fuel = (string) ($_POST['fuel'] ?? '');
    if (!in_array($fuel, LAB5_FUELS, true)) {
        $errors[] = 'Invalid fuel type.';
    }

    $priceRaw = str_replace(',', '.', trim((string) ($_POST['price'] ?? '')));
    if ($priceRaw === '' || !is_numeric($priceRaw)) {
        $errors[] = 'Price must be a number.';
    }
    $price = (float) $priceRaw;
    if ($price <= 0 || $price > 9999999.99) {
        $errors[] = 'Price must be positive and realistic.';
    }

    $color = trim((string) ($_POST['color'] ?? ''));
    if ($color === '' || strlen($color) > 60) {
        $errors[] = 'Color is required (max 60 characters).';
    }

    $ageRaw = $_POST['age_years'] ?? '';
    if ($ageRaw === '' || !ctype_digit((string) $ageRaw)) {
        $errors[] = 'Age (years) must be a whole number.';
    }
    $age = (int) $ageRaw;
    if ($age < 0 || $age > 80) {
        $errors[] = 'Age must be between 0 and 80 years.';
    }

    $history = trim((string) ($_POST['history'] ?? ''));
    if (strlen($history) > 8000) {
        $errors[] = 'History is too long.';
    }

    $id = null;
    if ($isUpdate) {
        $idRaw = $_POST['id'] ?? '';
        if ($idRaw === '' || !ctype_digit((string) $idRaw)) {
            $errors[] = 'Missing car id for update.';
        } else {
            $id = (int) $idRaw;
            if ($id < 1) {
                $errors[] = 'Invalid car id.';
            }
        }
    }

    if ($errors !== []) {
        return ['ok' => false, 'errors' => $errors];
    }

    return [
        'ok' => true,
        'errors' => [],
        'data' => [
            'id' => $id,
            'category_id' => $categoryId,
            'model' => $model,
            'engine_power' => $engine,
            'fuel' => $fuel,
            'price' => round($price, 2),
            'color' => $color,
            'age_years' => $age,
            'history' => $history === '' ? null : $history,
        ],
    ];
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: ../browse.php');
    exit;
}

$isUpdate = isset($_POST['id']) && (string) $_POST['id'] !== '';
$validation = lab5_validate_car_input($isUpdate);

if (!$validation['ok'] || !isset($validation['data'])) {
    $msg = implode(' ', $validation['errors']);
    $idForRedirect = isset($_POST['id']) && ctype_digit((string) $_POST['id']) ? (int) $_POST['id'] : 0;
    if ($idForRedirect > 0) {
        header('Location: ../edit.php?id=' . $idForRedirect . '&err=' . rawurlencode($msg));
    } else {
        header('Location: ../add.php?err=' . rawurlencode($msg));
    }
    exit;
}

$d = $validation['data'];

try {
    $pdo = lab5_pdo();

    $checkCat = $pdo->prepare('SELECT 1 FROM categories WHERE id = ? LIMIT 1');
    $checkCat->execute([(int) $d['category_id']]);
    if (!$checkCat->fetchColumn()) {
        header('Location: ../add.php?err=' . rawurlencode('Invalid category.'));
        exit;
    }

    if ($isUpdate) {
        $checkCar = $pdo->prepare('SELECT 1 FROM cars WHERE id = ? LIMIT 1');
        $checkCar->execute([(int) $d['id']]);
        if (!$checkCar->fetchColumn()) {
            header('Location: ../browse.php?err=' . rawurlencode('Car not found.'));
            exit;
        }

        $sql = 'UPDATE cars SET category_id = ?, model = ?, engine_power = ?, fuel = ?, price = ?, color = ?, age_years = ?, history = ?
                WHERE id = ?';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            (int) $d['category_id'],
            $d['model'],
            (int) $d['engine_power'],
            $d['fuel'],
            $d['price'],
            $d['color'],
            (int) $d['age_years'],
            $d['history'],
            (int) $d['id'],
        ]);
        header('Location: ../browse.php?ok=' . rawurlencode('Car updated.'));
        exit;
    }

    $sql = 'INSERT INTO cars (category_id, model, engine_power, fuel, price, color, age_years, history)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        (int) $d['category_id'],
        $d['model'],
        (int) $d['engine_power'],
        $d['fuel'],
        $d['price'],
        $d['color'],
        (int) $d['age_years'],
        $d['history'],
    ]);
    header('Location: ../browse.php?ok=' . rawurlencode('Car added.'));
    exit;
} catch (Throwable $e) {
    $idForRedirect = isset($_POST['id']) && ctype_digit((string) $_POST['id']) ? (int) $_POST['id'] : 0;
    if ($idForRedirect > 0) {
        header('Location: ../edit.php?id=' . $idForRedirect . '&err=' . rawurlencode('Database error.'));
    } else {
        header('Location: ../add.php?err=' . rawurlencode('Database error.'));
    }
    exit;
}
