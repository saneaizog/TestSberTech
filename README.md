# TestSberTech

Тестовое задание для команды Сбертеха

## 1. Требования

### 1.1. Функциональные требования

#### 1.1.1. Авторизация и регистрация

**Регистрация пользователя:**

- Пользователь должен иметь возможность зарегистрироваться в системе, указав `username`, `email`, и `password`.
- Валидация данных при регистрации:
  - Длина `username` от 4 до 20 символов.
  - `email` должен быть в правильном формате.
  - `password` должен соответствовать требованиям безопасности (длина, сложность).
- После успешной регистрации пользователь получает подтверждение о создании аккаунта.

**Авторизация пользователя:**

- Пользователь должен иметь возможность авторизоваться по `username` и `password`.
- После успешной авторизации система должна возвращать токен доступа (JWT или другой), используемый для аутентификации в последующих запросах.

**Управление профилем пользователя:**

- Пользователь может обновить свой профиль (`username`, `email`).
- Изменение должно быть доступно через web-интерфейс.

#### 1.1.2. Каталог фотографий

**Загрузка фотографий:**

- Пользователь может загружать фотографии через web-интерфейс.
- Каждая фотография может сопровождаться текстовым описанием длиной до 1000 символов и геопозицией (широта и долгота).
- Система должна загружать фотографии в S3-совместимое хранилище (например, MinIO).

**Обновление и удаление фотографий:**

- Пользователь может редактировать описание и геопозицию фотографии.
- Пользователь может удалить фотографию.

**Просмотр фотографий:**

- Пользователь может просматривать список своих фотографий.
- Просмотр фото других пользователей возможен только для друзей.

#### 1.1.3. Лайки

**Ставить лайки фотографиям друзей:**

- Пользователь может ставить лайки на фотографии других пользователей, если они находятся в списке его друзей.

**Удаление лайков:**

- Пользователь может удалить лайк с фотографии.

**Просмотр лайков:**

- Пользователь может видеть, кто поставил лайк его фотографиям.

#### 1.1.4. Функционал друзей

**Добавление в друзья:**

- Пользователь может добавлять других пользователей в друзья.
- Добавление возможно только при согласии с обеих сторон.

**Удаление друзей:**

- Пользователь может удалять других пользователей из списка друзей.

**Просмотр списка друзей:**

- Пользователь может просматривать список своих друзей.

#### 1.1.5. Работа с геолокацией

**Добавление геопозиции к фотографии:**

- Пользователь может указать географическое местоположение при добавлении фотографии (широта и долгота).

**Фильтрация фотографий по геопозиции:**

- Система может позволять фильтровать фотографии по географическому положению, если это потребуется.

### 1.2. Нефункциональные требования

#### 1.2.1. Безопасность

**Шифрование паролей:**

- Пароли пользователей должны храниться в зашифрованном виде (использование алгоритмов хеширования, таких как bcrypt).

**Защита API:**

- Использование токенов (JWT) для аутентификации и авторизации запросов на backend.

**Межсервисная безопасность:**

- Взаимодействие между микросервисами должно быть защищено с использованием безопасных протоколов передачи данных (например, HTTPS).

**Валидация данных:**

- Все данные, вводимые пользователями, должны проходить проверку на корректность (валидацию) и фильтрацию для защиты от SQL-инъекций и XSS-атак.

#### 1.2.2. Производительность

**Скалируемость:**

- Приложение должно поддерживать горизонтальное масштабирование микросервисов для увеличения производительности (добавление новых узлов в кластер при увеличении нагрузки).

**Кеширование:**

- Использование кеширования (например, Redis) для повышения скорости работы при частых запросах, например, при просмотре фотографий или лайков.

**Оптимизация запросов к S3-хранилищу:**

- Ограничение объема передаваемых данных при работе с S3-хранилищем (например, использование миниатюр для фотографий при просмотре).

#### 1.2.3. Доступность

- Регулярное создание резервных копий для S3-хранилища и базы данных c переодичностью раз в сутки.

#### 1.2.4. Масштабируемость

**Микросервисная архитектура:**

- Разделение функционала на независимые микросервисы (например, микросервис авторизации, микросервис фотографий, микросервис лайков и микросервис друзей), которые могут масштабироваться независимо друг от друга.

**Автономность сервисов:**

- Микросервисы должны быть независимыми и иметь возможность обновляться или масштабироваться без необходимости останавливать другие компоненты системы.

#### 1.2.5. Интерфейс

- Интерфейс должен быть интуитивно понятным, с возможностью быстрого доступа к функциям добавления фотографий, управления профилем, работы с друзьями и лайками.

#### 1.2.6. Мониторинг и логирование

**Логирование:**

- Ведение логов работы системы для отслеживания проблем и их анализа.

**Мониторинг:**

- Система должна поддерживать мониторинг с метриками производительности, ошибки, времени ответа API и других параметров (использование инструментов вроде Prometheus, Grafana).

### 1.3. Системные требования

- Приложение должно быть развернуто на надежной серверной инфраструктуре с поддержкой контейнеризации
- Приложение должно использовать реляционную базу данных для хранения информации о пользователях, фотографиях и друзьях.
- Для хранения фотографий используется S3-совместимое хранилище.

### 1.4. Ожидаемые сценарии использования

**Регистрация пользователя:**

- Пользователь заходит на сайт, заполняет форму регистрации, создает учетную запись.

**Авторизация:**

- Пользователь вводит свои данные для входа и получает доступ к личному кабинету.

**Добавление фотографии:**

- Пользователь загружает фотографию, добавляет описание и геопозицию, после чего фотография сохраняется в хранилище.

**Управление друзьями:**

- Пользователь добавляет других пользователей в список друзей, чтобы иметь возможность лайкать их фотографии.

**Лайки фотографий друзей:**

- Пользователь заходит на страницу фотографии друга и ставит лайк.

---

## 2. Архитектура решения в нотации C4

#### Уровень системы

```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Photo_platform - System Context"]
    style diagram fill:#000000,stroke:#000000

    1["<div style='font-weight: bold; color: #ffffff;'>Пользователь</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Person]</div><div style='font-size: 80%; margin-top:10px; color: #ffffff;'>Пользователь,<br />взаимодействующий с системой.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    13("<div style='font-weight: bold; color: #ffffff;'>MinIO</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Software System]</div><div style='font-size: 80%; margin-top:10px; color: #ffffff;'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 13 fill:#1168bd,stroke:#0b4884,color:#ffffff
    2("<div style='font-weight: bold; color: #ffffff;'>Photo_platform</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Software System]</div>")
    style 2 fill:#1168bd,stroke:#0b4884,color:#ffffff

    13-. "<div style='color: #ffffff;'>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->2
    2-. "<div style='color: #ffffff;'>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->13
    1-. "<div style='color: #ffffff;'>Просматривает данные</div><div style='font-size: 70%'></div>" .->2
  end

```

#### Уровень контейнеров

 ```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Photo_platform - Containers"]
    style diagram fill:#000000,stroke:#000000

    1["<div style='font-weight: bold; color: #ffffff;'>Пользователь</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Person]</div><div style='font-size: 80%; margin-top:10px; color: #ffffff;'>Пользователь,<br />взаимодействующий с системой.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    13("<div style='font-weight: bold; color: #ffffff;'>MinIO</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Software System]</div><div style='font-size: 80%; margin-top:10px; color: #ffffff;'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 13 fill:#1168bd,stroke:#0b4884,color:#ffffff

    subgraph 2 ["Photo_platform"]
      style 2 fill:#000000,stroke:#0b4884,color:#0b4884

      11("<div style='font-weight: bold; color: #ffffff;'>База данных</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Container]</div>")
      style 11 fill:#438dd5,stroke:#2e6295,color:#ffffff
      3("<div style='font-weight: bold; color: #ffffff;'>UI платформы</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Container]</div>")
      style 3 fill:#438dd5,stroke:#2e6295,color:#ffffff
      6("<div style='font-weight: bold; color: #ffffff;'>API Gateway</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Container]</div>")
      style 6 fill:#438dd5,stroke:#2e6295,color:#ffffff
    end

    3-. "<div style='color: #ffffff;'>Передает данные</div><div style='font-size: 70%'></div>" .->6
    6-. "<div style='color: #ffffff;'>Сохраняет данные индексации</div><div style='font-size: 70%'></div>" .->11
    13-. "<div style='color: #ffffff;'>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->3
    6-. "<div style='color: #ffffff;'>Отображение фотографий</div><div style='font-size: 70%'></div>" .->3
    6-. "<div style='color: #ffffff;'>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->13
    1-. "<div style='color: #ffffff;'>Просматривает данные</div><div style='font-size: 70%'></div>" .->3
  end

```

#### Компонентный уровень

```mermaid
graph BT
  linkStyle default fill:#ffffff

  subgraph diagram ["Photo_platform - API Gateway - Components"]
    style diagram fill:#000000,stroke:#000000

    3("<div style='font-weight: bold; color: #ffffff;'>UI платформы</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Container]</div>")
    style 3 fill:#438dd5,stroke:#2e6295,color:#ffffff
    13("<div style='font-weight: bold; color: #ffffff;'>MinIO</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Software System]</div><div style='font-size: 80%; margin-top:10px; color: #ffffff;'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 13 fill:#1168bd,stroke:#0b4884,color:#ffffff

    subgraph 6 ["API Gateway"]
      style 6 fill:#000000,stroke:#2e6295,color:#2e6295

      7("<div style='font-weight: bold; color: #ffffff;'>Auth Service</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Component]</div>")
      style 7 fill:#85bbf0,stroke:#5d82a8,color:#000000
      8("<div style='font-weight: bold; color: #ffffff;'>User Profile Service</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Component]</div>")
      style 8 fill:#85bbf0,stroke:#5d82a8,color:#000000
      9("<div style='font-weight: bold; color: #ffffff;'>Photo Service</div><div style='font-size: 70%; margin-top: 0px; color: #ffffff;'>[Component]</div>")
      style 9 fill:#85bbf0,stroke:#5d82a8,color:#000000
    end

    13-. "<div style='color: #ffffff;'>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->3
    3-. "<div style='color: #ffffff;'>Запрос на получение<br />пользователя</div><div style='font-size: 70%'></div>" .->7
    7-. "<div style='color: #ffffff;'>Получение и обновления<br />информации о пользователе</div><div style='font-size: 70%'></div>" .->8
    8-. "<div style='color: #ffffff;'>Получение информации о<br />фотографиях пользователя</div><div style='font-size: 70%'></div>" .->9
    3-. "<div style='color: #ffffff;'>Запрос на отображение фото</div><div style='font-size: 70%'></div>" .->9
    9-. "<div style='color: #ffffff;'>Отображение фотографий</div><div style='font-size: 70%'></div>" .->3
    9-. "<div style='color: #ffffff;'>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->13
    9-. "<div style='color: #ffffff;'>Получает данные о<br />пользователе, который<br />загружает фотографию</div><div style='font-size: 70%'></div>" .->8
  end

```

## 3. ER-диаграмма

```mermaid
erDiagram
    User {
        int id PK
        string username
        string email
    }

    Photo {
        string photoId PK
        int userId FK
        string caption
        float latitude
        float longitude
    }

    Like {
        int likeId PK
        int userId FK
        string photoId FK
    }

    Friendship {
        int userId FK
        int friendUserId FK
    }

    User ||--o{ Photo : "создает"
    User ||--o{ Like : "ставит лайк"
    User ||--o{ Friendship : "имеет друга"
    Photo ||--o{ Like : "получает лайк"
    User ||--o{ Friendship : "является другом"
```
