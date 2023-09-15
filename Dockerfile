# Usamos una imagen oficial de PHP 8.1.4 con Apache como base
FROM php8.1.4-apache

# Habilitamos el módulo de Apache mod_rewrite
RUN a2enmod rewrite

# Instalamos las extensiones de PHP necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Definimos el directorio de trabajo dentro del contenedor
WORKDIR varwwwhtml

# Copiamos el código fuente de Laravel a la imagen
#COPY applaravel varwwwhtmlapplaravel
COPY . varwwwhtml

# Instalamos Composer globalmente
RUN curl -sS httpsgetcomposer.orginstaller  php -- --install-dir=usrlocalbin --filename=composer

# Instalamos las dependencias de Composer
RUN composer install
RUN chmod -R 777 storage

# Copiamos el archivo de configuración .env
COPY .env.example .env

# Generamos la clave de la aplicación
RUN php artisan keygenerate
RUN php artisan migrate
RUN php artisan dbseed --class=DefaultUserSeeder

# Exponemos el puerto 80 para que se pueda acceder al servidor web
EXPOSE 80

# Comando por defecto para iniciar Apache (se ejecuta al iniciar el contenedor)
CMD [apache2-foreground]

# Puedes agregar cualquier otro comando que necesites aquí
