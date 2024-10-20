# TestSberTech

Тестовое задание для команды Сбертеха

## 1. Требования

### Функциональные требования

**Регистрация пользователя:**

- Пользователь должен иметь возможность зарегистрироваться в системе, указав `username`, `email`, и `password`.
- Валидация данных при регистрации:
  - Длина `username` от 4 до 20 символов.
  - `email` должен быть в правильном формате.
  - `password` должен соответствовать требованиям безопасности (должен содержать минимум 8 символов, включая строчные и прописные буквы, цифры и специальные символы)
- После успешной регистрации пользователь получает подтверждение о создании аккаунта.

**Авторизация пользователя:**

- Пользователь должен иметь возможность авторизоваться по `username` и `password`.
- После успешной авторизации система должна возвращать токен доступа, используемый для аутентификации в последующих запросах.

**Управление профилем пользователя:**

- Пользователь может обновить свой профиль (`username`, `email`).
- Изменение должно быть доступно через web-интерфейс.
  

#### Сервис фотографий

**Загрузка фотографий:**

- Пользователь может загружать фотографии через web-интерфейс.
- Каждая фотография может сопровождаться текстовым описанием длиной до 1000 символов и геопозицией (широта и долгота).
- Система должна загружать фотографии в S3-совместимое хранилище MinIO.

**Обновление и удаление фотографий:**

- Пользователь может редактировать описание и геопозицию фотографии.
- Пользователь может удалить фотографию.

**Просмотр фотографий:**

- Пользователь может просматривать список своих фотографий.
- Просмотр фото других пользователей возможен **толкьо** для друзей.

#### Лайки

- Пользователь может ставить лайки на фотографии других пользователей, если они находятся в списке его друзей.

- Пользователь может удалить лайк с фотографии.

- Пользователь может видеть, кто поставил лайк его фотографиям.

#### Функционал друзей

- Пользователь может добавлять других пользователей в друзья.

- Пользователь может удалять других пользователей из списка друзей.

- Пользователь может просматривать список своих друзей.

#### Работа с геолокацией

- Пользователь может указать географическое местоположение при добавлении фотографии (широта и долгота).

### 1.2. Нефункциональные требования

#### Безопасность

- Пароли пользователей должны храниться в зашифрованном виде 

- Использование токенов  для аутентификации и авторизации запросов на backend.

- Взаимодействие между микросервисами должно быть защищено с использованием HTTPS протокола
  
- Все данные, вводимые пользователями, должны проходить валидацию

#### Производительность

- Система должно поддерживать горизонтальное масштабирование микросервисов для увеличения производительности.

- Использование кеширования для повышения скорости работы при частых запросах, например, при просмотре фотографий или лайков.

- Ограничение объема передаваемых данных при работе с S3-хранилищем.

#### Доступность

- Регулярное создание резервных копий для S3-хранилища и базы данных c переодичностью раз в сутки.

#### Масштабируемость

- Разделение функционала на независимые микросервисы (например, микросервис авторизации, микросервис фотографий, микросервис лайков и микросервис друзей), которые могут масштабироваться независимо друг от друга.

- Микросервисы должны быть независимыми и иметь возможность обновляться или масштабироваться без необходимости останавливать другие компоненты.

#### Интерфейс

- Интерфейс должен быть интуитивно понятным, с возможностью быстрого доступа к функциям добавления фотографий, управления профилем, работы с друзьями и лайками.

#### Мониторинг и логирование

- Ведение логов работы системы для отслеживания проблем и их анализа.

- Система должна поддерживать мониторинг с метриками производительности, ошибки, времени ответа API и других параметров с использованием Grafana и Prometheus.

### Системные требования

- Приложение должно быть развернуто на надежной серверной инфраструктуре с поддержкой контейнеризации
  
- Приложение должно использовать реляционную базу данных для хранения информации о пользователях, фотографиях и друзьях
  
- Для хранения фотографий используется S3-совместимое хранилище

### Ожидаемые сценарии использования

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
    style diagram fill:#ffffff,stroke:#ffffff

    1["<div style='font-weight: bold'>Пользователь</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Пользователь,<br />взаимодействующий с системой.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    16("<div style='font-weight: bold'>MinIO</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div><div style='font-size: 80%; margin-top:10px'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 16 fill:#1168bd,stroke:#0b4884,color:#ffffff
    2("<div style='font-weight: bold'>Photo_platform</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 2 fill:#1168bd,stroke:#0b4884,color:#ffffff

    16-. "<div>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->2
    2-. "<div>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->16
    1-. "<div>Просматривает данные</div><div style='font-size: 70%'></div>" .->2
  end
```

#### Уровень контейнеров

 ```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Photo_platform - Containers"]
    style diagram fill:#ffffff,stroke:#ffffff

    1["<div style='font-weight: bold'>Пользователь</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Пользователь,<br />взаимодействующий с системой.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    16("<div style='font-weight: bold'>MinIO</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div><div style='font-size: 80%; margin-top:10px'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 16 fill:#1168bd,stroke:#0b4884,color:#ffffff

    subgraph 2 ["Photo_platform"]
      style 2 fill:#ffffff,stroke:#0b4884,color:#0b4884

      14("<div style='font-weight: bold'>База данных</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 14 fill:#438dd5,stroke:#2e6295,color:#ffffff
      3("<div style='font-weight: bold'>UI платформы</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 3 fill:#438dd5,stroke:#2e6295,color:#ffffff
      6("<div style='font-weight: bold'>API Gateway</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 6 fill:#438dd5,stroke:#2e6295,color:#ffffff
    end

    3-. "<div>Передает данные</div><div style='font-size: 70%'></div>" .->6
    6-. "<div>Сохраняет данные индексации</div><div style='font-size: 70%'></div>" .->14
    16-. "<div>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->3
    6-. "<div>Отображение фотографий</div><div style='font-size: 70%'></div>" .->3
    6-. "<div>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->16
    1-. "<div>Просматривает данные</div><div style='font-size: 70%'></div>" .->3
  end
```

#### Компонентный уровень

```mermaid
graph BT
  linkStyle default fill:#ffffff

  subgraph diagram ["Photo_platform - API Gateway - Components"]
    style diagram fill:#ffffff,stroke:#ffffff

    3("<div style='font-weight: bold'>UI платформы</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
    style 3 fill:#438dd5,stroke:#2e6295,color:#ffffff
    16("<div style='font-weight: bold'>MinIO</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div><div style='font-size: 80%; margin-top:10px'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 16 fill:#1168bd,stroke:#0b4884,color:#ffffff

    subgraph 6 ["API Gateway"]
      style 6 fill:#ffffff,stroke:#2e6295,color:#2e6295

      10("<div style='font-weight: bold'>Like Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 10 fill:#85bbf0,stroke:#5d82a8,color:#000000
      11("<div style='font-weight: bold'>Friend Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 11 fill:#85bbf0,stroke:#5d82a8,color:#000000
      12("<div style='font-weight: bold'>Redis Cache</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div><div style='font-size: 80%; margin-top:10px'>Служит для кэширования<br />данных.</div>")
      style 12 fill:#85bbf0,stroke:#5d82a8,color:#000000
      7("<div style='font-weight: bold'>Auth Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 7 fill:#85bbf0,stroke:#5d82a8,color:#000000
      8("<div style='font-weight: bold'>User Profile Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 8 fill:#85bbf0,stroke:#5d82a8,color:#000000
      9("<div style='font-weight: bold'>Photo Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 9 fill:#85bbf0,stroke:#5d82a8,color:#000000
    end

    16-. "<div>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->3
    3-. "<div>Запрос на получение<br />пользователя</div><div style='font-size: 70%'></div>" .->7
    7-. "<div>Получение и обновления<br />информации о пользователе</div><div style='font-size: 70%'></div>" .->8
    8-. "<div>Получение информации о<br />фотографиях пользователя</div><div style='font-size: 70%'></div>" .->9
    3-. "<div>Запрос на отображение фото</div><div style='font-size: 70%'></div>" .->9
    9-. "<div>Отображение фотографий</div><div style='font-size: 70%'></div>" .->3
    9-. "<div>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->16
    9-. "<div>Получает данные о<br />пользователе, который<br />загружает фотографию</div><div style='font-size: 70%'></div>" .->8
    10-. "<div>Получение данных о фотографии</div><div style='font-size: 70%'></div>" .->9
    10-. "<div>Проверка, является ли<br />владелец фотографии другом</div><div style='font-size: 70%'></div>" .->11
    10-. "<div>Получение данных о<br />пользователе, который ставит<br />лайк</div><div style='font-size: 70%'></div>" .->8
    3-. "<div>Запрос на добавление лайка</div><div style='font-size: 70%'></div>" .->10
    3-. "<div>Запрос на управление друзьями</div><div style='font-size: 70%'></div>" .->11
    11-. "<div>Получение и обновление данных<br />о друзьях</div><div style='font-size: 70%'></div>" .->8
    8-. "<div>Кэширование информации о<br />пользователе</div><div style='font-size: 70%'></div>" .->12
    9-. "<div>Кэширование фотографий</div><div style='font-size: 70%'></div>" .->12
    10-. "<div>Кэширование данных о лайках</div><div style='font-size: 70%'></div>" .->12
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

## 3. Макеты 
![Макеты](/Макеты_сайта.png)
