# Usamos una imagen oficial de PHP 8.1.4 con Apache como base
FROM php:8.1.4-apache

# Definimos el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Copiamos el código fuente de Laravel a la imagen
COPY . /var/www/html

# Instalamos Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN composer install --no-ansi --no-dev --no-interaction --no-progress --optimize-autoloader --no-scripts
# RUN composer require --dev barryvdh/laravel-ide-helper

# Instalamos el paquete laravel/ui
RUN composer require laravel/ui

# Generamos las rutas de autenticación
RUN php artisan ui vue --auth

# Instalamos las dependencias de Composer
# RUN composer install

# Asignamos permisos adecuados a la carpeta storage y bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Copiamos el archivo de configuración .env
COPY .env.example .env
COPY .env /var/www/html/.env

# Generamos la clave de la aplicación
# RUN php artisan key:generate

# Modificamos la ruta por defecto del index.php
RUN sed -i 's/\/var\/www\/html/\/var\/www\/html\/public/g' /etc/apache2/sites-enabled/000-default.conf

# Exponemos el puerto 80 para que se pueda acceder al servidor web
EXPOSE 80

# Comando por defecto para iniciar Apache (se ejecuta al iniciar el contenedor)
CMD ["apache2-foreground"]

# Puedes agregar cualquier otro comando que necesites aquí
