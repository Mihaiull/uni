-- Optional: create the same schema manually (normally PHP creates this file on first request).
-- sqlite3 data/lab5.sqlite < sql/schema.sqlite.sql

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS cars (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    category_id INTEGER NOT NULL REFERENCES categories (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    model TEXT NOT NULL,
    engine_power INTEGER NOT NULL,
    fuel TEXT NOT NULL,
    price NUMERIC NOT NULL,
    color TEXT NOT NULL,
    age_years INTEGER NOT NULL,
    history TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_cars_category ON cars (category_id);

INSERT OR IGNORE INTO categories (id, name) VALUES
    (1, 'Sedan'),
    (2, 'SUV'),
    (3, 'Hatchback'),
    (4, 'Coupe'),
    (5, 'Van / MPV'),
    (6, 'Other');
