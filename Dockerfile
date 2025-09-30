FROM php:8.2-apache

# Install dependencies umum
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Copy seluruh source code Heimdall
COPY . /var/www/html

# Set folder dan permission
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy ikon ke public storage
# RUN mkdir -p /var/www/html/public/storage/icons
# COPY icons/* /var/www/html/public/storage/icons/

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080
