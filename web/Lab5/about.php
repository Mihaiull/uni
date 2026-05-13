<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/db.php';
require_once __DIR__ . '/includes/layout.php';

lab5_render_head(['title' => 'About', 'active' => 'about']);
?>
<section class="panel">
    <h1>About</h1>
    <p>This page exists only because the assignment required at least five pages.</p>
</section>
<?php
lab5_render_foot();
