FROM yiisoftware/yii2-php:7.0-apache

RUN sed -i -e 's|/app/web|/app/frontend/web|g' /etc/apache2/sites-available/000-default.conf && \
    sed -i -e 's|debian stretch main|debian stretch main contrib non-free|g' /etc/apt/sources.list && \
    sed -i -e 's|debian-security stretch/updates main|debian-security stretch/updates main contrib non-free|g' /etc/apt/sources.list && \
    sed -i -e 's|debian stretch-updates main|debian stretch-updates main contrib non-free|g' /etc/apt/sources.list && \    
    apt update && \
    apt install -yy --no-install-recommends --no-install-suggests \
    zip ffmpeg libjpeg-dev libpng-dev libfreetype-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr && docker-php-ext-install -j "$(nproc)" gd && \
    apt clean && \
    apt autoremove -yy --purge && \
    rm -rf /var/lib/apt/lists/* \
           /var/cache/apt/archives/*.deb \
           /var/cache/apt/*cache.bin
