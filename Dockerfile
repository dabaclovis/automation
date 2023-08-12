FROM php:8.1-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
      build-essential \
      libpng-dev \
      libjpeg62-turbo-dev \
      libfreetype6-dev \
      locales \
      zip \
      jpegoptim optipng pngquant gifsicle \
      vim \
      unzip \
      git \
      curl 
      

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY . /var/www

EXPOSE 9000
CMD ["php-fpm"]
