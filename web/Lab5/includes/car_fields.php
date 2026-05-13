<?php

declare(strict_types=1);

require_once __DIR__ . '/db.php';
require_once __DIR__ . '/car_helpers.php';

/**
 * @param array<string,mixed> $v
 * @param array<int, array{id:int,name:string}> $categories
 */
function lab5_render_car_fields(array $v, array $categories): void
{
    $categoryId = (string) ($v['category_id'] ?? '');
    $model = (string) ($v['model'] ?? '');
    $engine = (string) ($v['engine_power'] ?? '');
    $fuel = (string) ($v['fuel'] ?? 'petrol');
    $price = (string) ($v['price'] ?? '');
    $color = (string) ($v['color'] ?? '');
    $age = (string) ($v['age_years'] ?? '');
    $history = (string) ($v['history'] ?? '');
    ?>
    <div class="form-grid">
        <label for="category_id">Category</label>
        <div>
            <select id="category_id" name="category_id" required>
                <option value="">— Select —</option>
                <?php foreach ($categories as $c) { ?>
                    <option value="<?= (int) $c['id'] ?>"<?= (string) (int) $c['id'] === $categoryId ? ' selected' : '' ?>>
                        <?= lab5_h((string) $c['name']) ?>
                    </option>
                <?php } ?>
            </select>
        </div>

        <label for="model">Model</label>
        <div>
            <input type="text" id="model" name="model" required maxlength="200" value="<?= lab5_h($model) ?>"
                   pattern=".{1,200}" title="Model name">
            <div class="field-hint">Required, up to 200 characters.</div>
        </div>

        <label for="engine_power">Engine power (HP)</label>
        <div>
            <input type="number" id="engine_power" name="engine_power" required min="1" max="2000" step="1"
                   value="<?= lab5_h($engine) ?>">
        </div>

        <label for="fuel">Fuel</label>
        <div>
            <select id="fuel" name="fuel" required>
                <?php foreach (LAB5_FUEL_LABELS as $val => $label) { ?>
                    <option value="<?= lab5_h($val) ?>"<?= $fuel === $val ? ' selected' : '' ?>><?= lab5_h($label) ?></option>
                <?php } ?>
            </select>
        </div>

        <label for="price">Price (EUR)</label>
        <div>
            <input type="number" id="price" name="price" required min="0.01" max="9999999.99" step="0.01"
                   value="<?= lab5_h($price) ?>">
        </div>

        <label for="color">Color</label>
        <div>
            <input type="text" id="color" name="color" required maxlength="60" value="<?= lab5_h($color) ?>">
        </div>

        <label for="age_years">Age (years)</label>
        <div>
            <input type="number" id="age_years" name="age_years" required min="0" max="80" step="1"
                   value="<?= lab5_h($age) ?>">
        </div>

        <label for="history">History / notes</label>
        <div>
            <textarea id="history" name="history" maxlength="8000" placeholder="Service history, accidents, owners…"><?= lab5_h($history) ?></textarea>
            <div class="field-hint">Optional; max 8000 characters.</div>
        </div>
    </div>
    <?php
}
