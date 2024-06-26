FROM devilbox/php-fpm-8.2

# Set working directory
WORKDIR /var/www

# Add docker php ext repo
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mbstring pdo_mysql zip exif pcntl gd memcached

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    git \
    curl \
    lua-zlib-dev \
    libmemcached-dev \
    nginx \
    libicu-dev \
    mc

# Install supervisor
RUN apt-get install -y supervisor
RUN docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN chown -R www-data:www-data /var/www

# Copy existing application directory contents
#COPY ../river-of-memory-web-app /var/www

# add root to www group
#RUN chmod -R ug+w /var/www/storage

# Copy existing application directory permissions
#COPY --chown=www:www ../river-of-memory-web-app /var/www

ADD workers /etc/supervisor/conf.d

# PHP Error Log Files
RUN mkdir /var/log/php
RUN touch /var/log/php/errors.log && chmod 777 /var/log/php/errors.log

# Deployment steps
#RUN composer install --optimize-autoloader --no-dev
#RUN chmod +x /var/www/docker/run.sh

# Expose port 9000 and start php-fpm server
EXPOSE 9000
USER 1000
CMD ["php-fpm"]
