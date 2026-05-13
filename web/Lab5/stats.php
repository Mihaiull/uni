<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/db.php';
require_once __DIR__ . '/includes/layout.php';

try {
    $pdo = lab5_pdo();
    $rows = $pdo->query(
        'SELECT c.name AS category, COUNT(x.id) AS cnt
         FROM categories c
         LEFT JOIN cars x ON x.category_id = c.id
         GROUP BY c.id, c.name
         ORDER BY c.name ASC'
    )->fetchAll();
    $total = (int) $pdo->query('SELECT COUNT(*) FROM cars')->fetchColumn();
} catch (Throwable $e) {
    $rows = [];
    $total = 0;
    $dbError = lab5_db_failure_user_message();
}

lab5_render_head(['title' => 'Stats', 'active' => 'stats']);
?>
<section class="panel">
    <h1>Inventory overview</h1>
    <?php if (isset($dbError)) { ?>
        <p class="msg msg-error"><?= lab5_h($dbError) ?></p>
    <?php } else { ?>
        <p>Total cars in stock: <strong><?= (int) $total ?></strong></p>
        <table class="data-table">
            <thead>
                <tr><th>Category</th><th>Cars</th></tr>
            </thead>
            <tbody>
            <?php foreach ($rows as $r) { ?>
                <tr>
                    <td><?= lab5_h((string) $r['category']) ?></td>
                    <td><?= (int) $r['cnt'] ?></td>
                </tr>
            <?php } ?>
            </tbody>
        </table>
    <?php } ?>
</section>
<?php
lab5_render_foot();
