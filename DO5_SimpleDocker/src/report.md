## Part 1. Готовый докер

- Взять официальный докер образ с nginx и выкачать его при помощи docker pull

![photo](../misc/images/my/1.1.png)

- Проверить наличие докер образа через docker images

![photo](../misc/images/my/1.2.png)

- Запустить докер образ через docker run -d [image_id|repository]

![photo](../misc/images/my/1.3.png)

- Проверить, что образ запустился через docker ps

![photo](../misc/images/my/1.4.png)

- Посмотреть информацию о контейнере через docker inspect [container_id|container_name]

![photo](../misc/images/my/1.5.png)

- По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера

![photo](../misc/images/my/1.6.png)
![photo](../misc/images/my/1.7.png)
![photo](../misc/images/my/1.8.png)

- Остановить докер образ через docker stop [container_id|container_name]; Проверить, что образ остановился через docker ps

![photo](../misc/images/my/1.9.png)

- Запустить докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду run

![photo](../misc/images/my/1.10.png)

- Проверить, что в браузере по адресу localhost:80 доступна стартовая страница nginx

![photo](../misc/images/my/1.11.png)

- Перезапустить докер контейнер через docker restart [container_id|container_name];Проверить любым способом, что контейнер запустился

![photo](../misc/images/my/1.12.png)

## Part 2. Операции с контейнером

- Прочитать конфигурационный файл nginx.conf внутри докер контейнера через команду exec

![photo](../misc/images/my/2.1.png)

- Создать на локальной машине файл nginx.conf, настроить в нем по пути /status отдачу страницы статуса сервера nginx

![photo](../misc/images/my/2.2.png)

- Скопировать созданный файл nginx.conf внутрь докер образа через команду docker cp

![photo](../misc/images/my/2.3.png)

- Перезапустить nginx внутри докер образа через команду exec

![photo](../misc/images/my/2.4.png)

- Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx

![photo](../misc/images/my/2.5.png)

- Экспортировать контейнер в файл container.tar через команду export

![photo](../misc/images/my/2.6.png)

- Остановить контейнер

![photo](../misc/images/my/2.7.png)

- Удалить образ через docker rmi [image_id|repository], не удаляя перед этим контейнеры

![photo](../misc/images/my/2.8.png)

- Удалить остановленный контейнер

![photo](../misc/images/my/2.9.png)

- Импортировать контейнер обратно через команду import

![photo](../misc/images/my/2.10.png)

- Запустить импортированный контейнер

![photo](../misc/images/my/2.11.png)

- Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx

![photo](../misc/images/my/2.12.png)