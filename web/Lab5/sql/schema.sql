-- Run this in your MySQL database on www.scs.ubbcluj.ro (phpMyAdmin or mysql client).
-- Replace nothing: run as-is after selecting your personal database.

CREATE TABLE IF NOT EXISTS categories (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_categories_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cars (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_id INT UNSIGNED NOT NULL,
    model VARCHAR(200) NOT NULL,
    engine_power SMALLINT UNSIGNED NOT NULL COMMENT 'Engine power in HP',
    fuel VARCHAR(40) NOT NULL,
    price DECIMAL(11,2) NOT NULL,
    color VARCHAR(60) NOT NULL,
    age_years TINYINT UNSIGNED NOT NULL COMMENT 'Vehicle age in years',
    history TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_cars_category (category_id),
    CONSTRAINT fk_cars_category FOREIGN KEY (category_id) REFERENCES categories (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO categories (id, name) VALUES
    (1, 'Sedan'),
    (2, 'SUV'),
    (3, 'Hatchback'),
    (4, 'Coupe'),
    (5, 'Van / MPV'),
    (6, 'Other');
