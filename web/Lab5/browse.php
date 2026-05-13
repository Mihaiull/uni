<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/db.php';
require_once __DIR__ . '/includes/layout.php';
require_once __DIR__ . '/includes/car_helpers.php';

$categories = [];
try {
    $categories = lab5_fetch_categories(lab5_pdo());
} catch (Throwable $e) {
    $categories = [];
    $browseDbError = lab5_db_failure_user_message();
}

$ok = isset($_GET['ok']) ? (string) $_GET['ok'] : '';
$err = isset($_GET['err']) ? (string) $_GET['err'] : '';

lab5_render_head(['title' => 'Browse cars', 'active' => 'browse']);
?>
<section class="panel">
    <h1>Browse by category</h1>
    <?php if (isset($browseDbError)) { ?>
        <p class="msg msg-error"><?= lab5_h($browseDbError) ?></p>
    <?php } else { ?>
        <?php if ($ok !== '') { ?><p class="msg msg-ok"><?= lab5_h($ok) ?></p><?php } ?>
        <?php if ($err !== '') { ?><p class="msg msg-error"><?= lab5_h($err) ?></p><?php } ?>

        <p id="js-last-filter-display" class="last-filter" aria-live="polite"></p>

        <div class="form-row">
            <label for="category_id">Category</label>
            <select id="category_id" name="category_id">
                <option value="">— Select —</option>
                <?php foreach ($categories as $c) { ?>
                    <option value="<?= (int) $c['id'] ?>"><?= lab5_h((string) $c['name']) ?></option>
                <?php } ?>
            </select>
            <button type="button" id="btn-load-cars" class="button">Load cars</button>
        </div>

        <p id="browse-status" class="muted"></p>
        <div id="cars-results"></div>
    <?php } ?>
</section>
<script src="assets/js/browse.js"></script>
<?php
lab5_render_foot();
