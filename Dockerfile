FROM php:8.2-fpm

# 安裝依賴
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl

# 安裝擴展
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# 獲取最新的 Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 設置工作目錄
WORKDIR /var/www

# 將當前應用程式的內容複製到 Docker 容器中
COPY . /var/www

# 將公共目錄設為根目錄
RUN mv /var/www/public /var/www/html

# 赋予存储目录写权限
RUN chown -R www-data:www-data /var/www/storage
RUN chmod -R 775 /var/www/storage

EXPOSE 9000
CMD ["php-fpm"]
