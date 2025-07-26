#!/bin/sh

set -e

echo "📦 Running Laravel setup tasks..."

# Ensure SQLite DB file exists and is writable by www-data
if [ "$DB_CONNECTION" = "sqlite" ]; then
  if [ ! -f "$DB_DATABASE" ]; then
    echo "🔧 Creating SQLite database file at $DB_DATABASE"
    mkdir -p "$(dirname "$DB_DATABASE")"
    touch "$DB_DATABASE"
  fi

  echo "🔒 Setting permissions for SQLite database and directory"
  chown www-data:www-data "$DB_DATABASE"
  chmod 664 "$DB_DATABASE"
  chown www-data:www-data "$(dirname "$DB_DATABASE")"
  chmod 775 "$(dirname "$DB_DATABASE")"
fi

# Set permissions for storage and cache directories
echo "🔧 Fixing permissions for storage and cache"
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

echo "🔄 Running migrations for $DB_CONNECTION..."
php artisan migrate --force

echo "🚀 Running optimizations..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ Laravel is optimized and ready."

# Run main process
exec "$@"
