FROM dunglas/frankenphp

RUN install-php-extensions \
    pcntl
    # Add other PHP extensions here...

COPY . /app

# make production build
RUN sed -i 's/APP_ENV=local/APP_ENV=production/' .env
RUN sed -i 's/APP_DEBUG=true/APP_DEBUG=false/' .env

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD ["php", "artisan", "octane:frankenphp"]