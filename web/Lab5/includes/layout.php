<?php

declare(strict_types=1);

require_once __DIR__ . '/db.php';

/**
 * @param array{title:string, active?:string} $opts
 */
function lab5_render_head(array $opts): void
{
    $title = $opts['title'];
    $active = $opts['active'] ?? '';
    ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= lab5_h($title) ?> — Second-hand cars</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<header class="site-header">
    <p class="brand">Second-hand cars</p>
    <nav class="main-nav">
        <a href="index.php" class="<?= $active === 'home' ? 'is-active' : '' ?>">Home</a>
        <a href="browse.php" class="<?= $active === 'browse' ? 'is-active' : '' ?>">Browse</a>
        <a href="add.php" class="<?= $active === 'add' ? 'is-active' : '' ?>">Add car</a>
        <a href="stats.php" class="<?= $active === 'stats' ? 'is-active' : '' ?>">Stats</a>
        <a href="about.php" class="<?= $active === 'about' ? 'is-active' : '' ?>">About</a>
    </nav>
</header>
<main class="site-main">
<?php
}

function lab5_render_foot(?string $extraScripts = null): void
{
    ?>
</main>
<?php if ($extraScripts !== null && $extraScripts !== '') { ?>
<script><?= $extraScripts ?></script>
<?php } ?>
</body>
</html>
<?php
}
