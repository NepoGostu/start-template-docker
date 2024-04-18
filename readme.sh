1) Склонировать репозиторий с докером и перейти в него
2) Из папки докер: docker-compose up -d

   !!! Если возникла ошибка с mysql то изменить права и перезапустить контейнер
   sudo chmod -R 777 .
   docker-compose down
   docker-compose up -d

3) Разрешить права записи в src
   sudo chmod -R o+rw src
   
4) Заходим внутрь контейнера с проектом
   docker exec -it <id-container> bash 
   
5) Клонируем проект в папку src или создаем свой новый проект

   Если новый проект:
     composer create-project laravel/laravel ./

   Если скачали готовый проект:
     Разрешить права записи в src (это нужно делать уже не из контейнера)
       sudo chmod -R o+rw src

6) Если скачали готовый проект:
  Создаем файл .env (пример можно взять из env.example.sh)
  Заходим внутрь контейнера с проектом
   docker exec -it <id-container> bash 

   composer install
   php artisan key:generate
   php artisan storage:link
   php artisan migrate
   chown -R www-data:www-data /var/www
   php artisan clear-compiled
   php artisan cache:clear
   php artisan route:clear
   php artisan view:clear
   php artisan config:clear
   php artisan migrate:fresh --seed 
   
   Установить vite в контейнере:
    apt update
    apt install nodejs npm
    npm install
    npm run build
