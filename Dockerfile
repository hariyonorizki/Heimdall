# Base image PHP + Apache (bisa pakai PHP 8.2)
FROM php:8.2-apache

# Install dependencies Laravel / Heimdall
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git \
    && docker-php-ext-install pdo_mysql zip

# Copy seluruh source code Heimdall ke container
COPY . /var/www/html

# Set webroot
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy ikon ke folder public/storage/icons
# RUN mkdir -p /var/www/html/public/storage/icons
# COPY icons/* /var/www/html/public/storage/icons/

# Enable mod_rewrite Apache untuk Laravel
RUN a2enmod rewrite

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Expose port
EXPOSE 8080
