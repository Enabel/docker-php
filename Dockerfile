ARG PHP_VERSION="8.3"

FROM php:${PHP_VERSION}-fpm-alpine AS no-debug

# Force Europe/Brussels as server time
RUN echo "Europe/Brussels" > /etc/timezone

# Install build deps
RUN apk add --no-cache $PHPIZE_DEPS \
        bash \
        icu-dev \
        freetype-dev libjpeg-turbo-dev libpng-dev zlib-dev libwebp-dev \
        libzip-dev \
        libxslt-dev libxml2-dev \
        oniguruma-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install -j$(nproc) intl gd zip xsl bcmath mysqli pdo pdo_mysql mbstring \
    && rm -rf /tmp/*

# Enabel pdo_mysql
RUN docker-php-ext-enable pdo_mysql opcache mbstring

# Install composer
ENV COMPOSER_HOME="/composer"
ENV PATH="./vendor/bin:/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER="1"
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

WORKDIR /usr/share/nginx/html

FROM no-debug AS debug
# Add Xdebug
RUN apk add --no-cache linux-headers \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /tmp/*

# Install PCOV
RUN pecl install pcov \
    && docker-php-ext-enable pcov \
    && rm -rf /tmp/*

FROM debug AS cli
# Set working directory
WORKDIR /app

# Install symfony-cli
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash \
    && apk add symfony-cli

# Default command
CMD ["php", "-a"]
