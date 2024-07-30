FROM php:7.4-apache

# Copy all PHP files
COPY ./src/*.php /var/www/html/

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod headers

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Create a phpinfo file for testing
RUN echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# Debugging: List contents and permissions
RUN ls -la /var/www/html

# Debugging: Show Apache configuration
RUN apache2ctl -S

EXPOSE 80

CMD ["apache2-foreground"]