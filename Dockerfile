# Usamos una imagen oficial de PHP 8.1.4 con Apache como base
FROM php:8.1.4-apache

# Habilitamos el módulo de Apache mod_rewrite
RUN a2enmod rewrite

# Instalamos las extensiones de PHP necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Definimos el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Copiamos el código fuente de Laravel a la imagen
#COPY applaravel /var/www/html/applaravel
COPY . /var/www/html

# Instalamos Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalamos las dependencias de Composer
# RUN composer install
RUN chmod -R 777 storage

# Copiamos el archivo de configuración .env
COPY .env.example .env
COPY .env /var/www/html/.env

# Generamos la clave de la aplicación
RUN php artisan key:generate

# Exponemos el puerto 80 para que se pueda acceder al servidor web
EXPOSE 80

# Comando por defecto para iniciar Apache (se ejecuta al iniciar el contenedor)
CMD ["apache2-foreground"]

# Puedes agregar cualquier otro comando que necesites aquí
