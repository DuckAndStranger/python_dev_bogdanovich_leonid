# API для получения информации из БД

## Описание проекта

Этот проект представляет собой API и скрипт агрегации для Базы данных.
Выбранная база данных - Postgres, вебсервер - Flask.

## Изменения относительно ТЗ

В базу данных authors_database добавлена таблица с комментариями, 
так как до этого не возможно было подсчитать какие комментари кем и под каким постом были оставлены.
Так же проект обернут в docker-compose.

## Установка и запуск

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/DuckAndStranger/python_dev_bogdanovich_leonid.git
   ```

2. Перейдите в директорию проекта:
   ```bash
   cd python_dev_bogdanovich_leonid
   ```

4. Запустите docker-compose
   ```bash
   docker-compose up
   ```

5. Проверьте работу с помощью запросов к API:
   1. http://localhost:5000/api/comments?login=login1
   2. http://localhost:5000/api/general?login=login1