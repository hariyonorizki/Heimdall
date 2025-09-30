#!/bin/bash
set -e

# Pastikan folder storage writable
mkdir -p /var/www/html/storage
mkdir -p /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Jalankan migration / generate key kalau perlu
if [ ! -f /var/www/html/.env ]; then
    cp /var/www/html/.env.example /var/www/html/.env
    php artisan key:generate
fi

# Jalankan Apache di foreground
apache2-foreground
