FROM yiisoftware/yii2-php:7.0-apache

# Change document root for Apache
RUN sed -i -e 's|/app/web|/app/frontend/web|g' /etc/apache2/sites-available/000-default.conf

# Add contrib non-free
RUN sed -i -e 's|debian stretch main|debian stretch main contrib non-free|g' /etc/apt/sources.list
RUN sed -i -e 's|debian-security stretch/updates main|debian-security stretch/updates main contrib non-free|g' /etc/apt/sources.list
RUN sed -i -e 's|debian stretch-updates main|debian stretch-updates main contrib non-free|g' /etc/apt/sources.list

# Enable JPEG support in GD
RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr && docker-php-ext-install -j "$(nproc)" gd

# Install ffmpeg
RUN apt update
RUN apt install ffmpeg -y