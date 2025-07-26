FROM php:8.4-fpm-alpine

# Install system dependencies, PHP extensions, and nginx
RUN apk add --no-cache \
    bash \
    nginx \
    sqlite-libs \
    sqlite-dev \
    libzip-dev \
    oniguruma-dev \
    curl \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_sqlite zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application code
COPY . .

# make production build
RUN sed -i 's/APP_ENV=local/APP_ENV=production/' .env
RUN sed -i 's/APP_DEBUG=true/APP_DEBUG=false/' .env

# Install PHP dependencies (production mode)
RUN composer install --no-dev --optimize-autoloader

# Set correct permissions for Laravel
RUN mkdir -p storage bootstrap/cache && \
    chown -R www-data:www-data storage bootstrap/cache && \
    find storage bootstrap/cache -type d -exec chmod 775 {} \; && \
    find storage bootstrap/cache -type f -exec chmod 664 {} \;

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy Nginx config
COPY nginx.conf /etc/nginx/http.d/default.conf

# Expose HTTP port
EXPOSE 8080

# Start services via entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
