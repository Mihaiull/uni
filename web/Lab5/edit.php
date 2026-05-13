<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/db.php';
require_once __DIR__ . '/includes/layout.php';
require_once __DIR__ . '/includes/car_helpers.php';
require_once __DIR__ . '/includes/car_fields.php';

$rawId = $_GET['id'] ?? '';
if ($rawId === '' || !ctype_digit((string) $rawId)) {
    header('Location: browse.php?err=' . rawurlencode('Pick a car from the browse list to edit it.'));
    exit;
}

$carId = (int) $rawId;
if ($carId < 1) {
    header('Location: browse.php?err=' . rawurlencode('Pick a car from the browse list to edit it.'));
    exit;
}

$categories = [];
$car = null;
try {
    $pdo = lab5_pdo();
    $categories = lab5_fetch_categories($pdo);
    $stmt = $pdo->prepare(
        'SELECT id, category_id, model, engine_power, fuel, price, color, age_years, history
         FROM cars WHERE id = ? LIMIT 1'
    );
    $stmt->execute([$carId]);
    $car = $stmt->fetch();
} catch (Throwable $e) {
    $car = null;
    $formDbError = lab5_db_failure_user_message();
}

if (!isset($formDbError) && !$car) {
    header('Location: browse.php?err=' . rawurlencode('Car not found.'));
    exit;
}

$err = isset($_GET['err']) ? (string) $_GET['err'] : '';

if (isset($formDbError)) {
    $defaults = [];
} else {
    $defaults = [
        'category_id' => (string) (int) $car['category_id'],
        'model' => (string) $car['model'],
        'engine_power' => (string) (int) $car['engine_power'],
        'fuel' => (string) $car['fuel'],
        'price' => (string) $car['price'],
        'color' => (string) $car['color'],
        'age_years' => (string) (int) $car['age_years'],
        'history' => (string) ($car['history'] ?? ''),
    ];
}

lab5_render_head(['title' => 'Edit car', 'active' => 'browse']);
?>
<section class="panel">
    <h1>Edit car</h1>
    <?php if (isset($formDbError)) { ?>
        <p class="msg msg-error"><?= lab5_h($formDbError) ?></p>
    <?php } else { ?>
        <?php if ($err !== '') { ?><p class="msg msg-error"><?= lab5_h($err) ?></p><?php } ?>
        <form class="car-form" method="post" action="actions/save_car.php" novalidate>
            <input type="hidden" name="id" value="<?= (int) $car['id'] ?>">
            <?php lab5_render_car_fields($defaults, $categories); ?>
            <div class="form-actions">
                <button type="submit" class="button">Update car</button>
                <a class="button button-secondary" id="btn-cancel-edit" href="browse.php">Cancel</a>
            </div>
        </form>
    <?php } ?>
</section>
<script src="assets/js/form_confirm.js"></script>
<?php
lab5_render_foot();
