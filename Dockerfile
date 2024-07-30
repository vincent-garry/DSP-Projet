FROM php:7.4-apache

# Copy all PHP files
COPY ./src/*.php /var/www/html/

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Debugging: List contents and permissions
RUN ls -l /var/www/html

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Debugging: Show Apache configuration
RUN apache2ctl -S

EXPOSE 80

CMD ["apache2-foreground"]