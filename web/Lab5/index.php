<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/db.php';
require_once __DIR__ . '/includes/layout.php';

lab5_render_head(['title' => 'Home', 'active' => 'home']);
?>
<section class="panel">
    <h1>Second-hand car stock</h1>
    <p>Use the navigation to browse cars by category (AJAX), add new listings, or review quick stats.</p>
    <ul class="bullet-list">
        <li><strong>Browse</strong> — pick a category; cars load without a full page reload.</li>
        <li><strong>Add / edit</strong> — choose a car from the list to edit; IDs are never typed manually.</li>
        <li><strong>Delete</strong> — confirm before a listing is removed.</li>
    </ul>
    <p><a class="button" href="browse.php">Go to browse</a></p>
</section>
<?php
lab5_render_foot();
