<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/db.php';
require_once __DIR__ . '/includes/layout.php';
require_once __DIR__ . '/includes/car_helpers.php';
require_once __DIR__ . '/includes/car_fields.php';

$categories = [];
try {
    $categories = lab5_fetch_categories(lab5_pdo());
} catch (Throwable $e) {
    $categories = [];
    $formDbError = lab5_db_failure_user_message();
}

$err = isset($_GET['err']) ? (string) $_GET['err'] : '';
$defaults = [
    'category_id' => '',
    'model' => '',
    'engine_power' => '',
    'fuel' => 'petrol',
    'price' => '',
    'color' => '',
    'age_years' => '',
    'history' => '',
];

lab5_render_head(['title' => 'Add car', 'active' => 'add']);
?>
<section class="panel">
    <h1>Add a car</h1>
    <?php if (isset($formDbError)) { ?>
        <p class="msg msg-error"><?= lab5_h($formDbError) ?></p>
    <?php } else { ?>
        <?php if ($err !== '') { ?><p class="msg msg-error"><?= lab5_h($err) ?></p><?php } ?>
        <form class="car-form" method="post" action="actions/save_car.php" novalidate>
            <?php lab5_render_car_fields($defaults, $categories); ?>
            <div class="form-actions">
                <button type="submit" class="button">Save car</button>
                <a class="button button-secondary" id="btn-cancel-add" href="browse.php">Cancel</a>
            </div>
        </form>
    <?php } ?>
</section>
<script src="assets/js/form_confirm.js"></script>
<?php
lab5_render_foot();
