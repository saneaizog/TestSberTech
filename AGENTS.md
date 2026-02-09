# AGENTS.md

Этот документ содержит инструкции и команды для агентных кодинговых агентов, работающих в этом репозитории.

## Язык кодирования

**ВАЖНО**: Весь код, комментарии, переменные и сообщения должны быть написаны исключительно на русском языке. Запрещено использовать английский язык в коде, за исключением:
- Названий стандартных библиотек и фреймворков
- Технических терминов, не имеющих русского аналога
- Ключевых слов языков программирования

## Обзор проекта

Это проект фотоплатформы для тестового задания SberTech. Система состоит из:
- Микросервисной архитектуры с API Gateway
- Аутентификации пользователей и управления профилями
- Загрузки/хранения фотографий с MinIO (S3-совместимое хранилище)
- Социальных функций (лайки, друзья)
- Веб UI платформы

## Архитектура

- **Фронтенд**: Веб UI платформа
- **Бэкенд**: API Gateway с микросервисами:
  - Auth Service (сервис аутентификации)
  - User Profile Service (сервис профилей пользователей)
  - Photo Service (сервис фотографий)
  - Like Service (сервис лайков)
  - Friend Service (сервис друзей)
  - Redis Cache (кэш Redis)
- **Хранилище**: MinIO (S3-совместимое)
- **База данных**: Реляционная СУБД для пользователей, фото, лайков, дружбы

## Команды сборки/тестирования/линтинга

⚠️ **Примечание**: В репозитории пока только документация и спецификации. Реального кода, скриптов сборки или тест-раннеров нет.

При добавлении реализации ожидаются команды:
```bash
# Сборка всех сервисов
npm run build
# или
docker-compose build

# Запуск тестов
npm test
# Один тест
npm test -- --testNamePattern="specific_test"

# Линтинг кода
npm run lint

# Проверка типов
npm run typecheck

# Запуск окружения разработки
npm run dev
# или
docker-compose up
```

## Соглашения по стилю кода

### Общие принципы
- Следовать паттернам микросервисной архитектуры
- Использовать TypeScript/JavaScript для Node.js сервисов
- Правильная обработка ошибок и логирование
- Использовать async/await для асинхронных операций
- Валидировать все входные данные

### Организация импортов
```javascript
// Встроенные модули Node.js
const fs = require('fs');
const path = require('path');

// Внешние зависимости
const express = require('express');
const bcrypt = require('bcrypt');

// Внутренние модули
const userService = require('../services/userService');
const { validateUser } = require('../utils/validation');
```

### Соглашения по именованию
- **Файлы**: kebab-case (user-service.js, photo-controller.js)
- **Переменные/функции**: camelCase (getUserData, uploadPhoto)
- **Константы**: UPPER_SNAKE_CASE (MAX_FILE_SIZE, JWT_SECRET)
- **Классы**: PascalCase (UserService, PhotoUploader)
- **Таблицы БД**: snake_case (user_profiles, photo_likes)
- **API endpoints**: kebab-case (/api/v1/user-profile, /api/v1/upload-photo)

### Обработка ошибок
```javascript
// Единый формат ошибок
const handleError = (res, error, statusCode = 500) => {
  console.error('Ошибка:', error);
  res.status(statusCode).json({
    error: true,
    message: error.message || 'Внутренняя ошибка сервера',
    timestamp: new Date().toISOString()
  });
};

// Валидация с конкретными ошибками
const validateRegistration = (data) => {
  const errors = [];
  
  if (!data.username || data.username.length < 4 || data.username.length > 20) {
    errors.push('Имя пользователя должно быть 4-20 символов');
  }
  
  if (!data.email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(data.email)) {
    errors.push('Неверный формат email');
  }
  
  if (!data.password || !/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/.test(data.password)) {
    errors.push('Пароль должен содержать 8+ символов: заглавные, строчные, цифры, спецсимволы');
  }
  
  return errors;
};
```

### Рекомендации по безопасности
- Хешировать пароли через bcrypt
- Использовать JWT токены для аутентификации
- Валидировать все входные данные
- Внедрить rate limiting
- Использовать HTTPS для всех соединений
- Никогда не логировать чувствительные данные (пароли, токены)

### Формат ответов API
```javascript
// Успешный ответ
res.status(200).json({
  success: true,
  data: result,
  timestamp: new Date().toISOString()
});

// Ошибка
res.status(400).json({
  success: false,
  error: {
    code: 'VALIDATION_ERROR',
    message: 'Неверные входные данные',
    details: validationErrors
  },
  timestamp: new Date().toISOString()
});
```

### Паттерны работы с БД
- Использовать пул соединений
- Правильная обработка транзакций
- Параметризованные запросы против SQL-инъекций
- Поля created_at, updated_at
- Soft delete где уместно

### Структура файлов (ожидаемая)
```
src/
├── services/
│   ├── authService.js
│   ├── userService.js
│   ├── photoService.js
│   ├── likeService.js
│   └── friendService.js
├── controllers/
│   ├── authController.js
│   ├── userController.js
│   └── photoController.js
├── middleware/
│   ├── auth.js
│   ├── validation.js
│   └── errorHandler.js
├── utils/
│   ├── database.js
│   ├── minio.js
│   └── redis.js
├── routes/
│   ├── auth.js
│   ├── users.js
│   ├── photos.js
│   ├── likes.js
│   └── friends.js
└── app.js
```

### Переменные окружения
Использовать файл `.env`:
```
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://user:pass@localhost/db
JWT_SECRET=your-secret-key
MINIO_ENDPOINT=localhost:9000
MINIO_ACCESS_KEY=minioadmin
MINIO_SECRET_KEY=minioadmin
REDIS_URL=redis://localhost:6379
```

## Рекомендации по тестированию
- Unit-тесты для всех функций сервисов
- Интеграционные тесты для API endpoints
- Тестировать ошибки и edge-кейсы
- Описательные имена тестов
- Мокировать внешние зависимости (БД, MinIO, Redis)

## Спецификация OpenAPI
API определен в `openapi.yaml`. Все endpoints должны следовать спецификации:
- Базовый URL: `/api/v1`
- Правильные HTTP статус-коды
- Схемы запросов/ответов
- Документация требований аутентификации

### Валидация OpenAPI спецификации
**ВАЖНО**: Если изменения касаются OpenAPI спецификаций, по завершении необходимо выполнить команду:
```bash
spectral lint openapi.yaml
```/

**Требования к результату:**
- В логах не должно быть ни одной ошибки (ERROR)
- Предупреждения (WARNINGS) допустимы
- При наличии ошибок необходимо исправить спецификацию перед завершением работы

**Установка Spectral (если не установлена):**
```bash
npm install -g @stoplight/spectral-cli
```

**Пример успешного выполнения:**
```
✓ openapi.yaml is valid
```

**Пример выполнения с ошибками:**
```
✖ openapi.yaml
  - Error: $.openapi should be equal to one of the allowed values
  - Error: $.info.contact is required
```

## Workflow разработки
1. Создавать feature-ветки от main
2. Писать тесты перед реализацией (TDD предпочтительно)
3. Все тесты проходят, код пролинчен
4. Обновлять документацию
5. Отправлять pull request на ревью

## Требования к производительности
- Кэширование Redis для часто запрашиваемых данных
- Пагинация для больших наборов данных
- Оптимизация запросов БД с индексами
- Пул соединений для БД и MinIO
- Рассмотреть CDN для статических файлов

## Мониторинг и логирование
- Структурированное логирование с таймстампами
- Request ID для трейсинга
- Мониторинг времени ответа API
- Health check endpoints
- Логирование ошибок с уровнями серьезности