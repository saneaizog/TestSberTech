# TestSberTech
Тестовое задание для команды Сбертеха 


## Архитектура решения в нотации C4 

#### Уровень системы
```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Photo_platform - System Context"]
    style diagram fill:#ffffff,stroke:#ffffff

    1["<div style='font-weight: bold'>Пользователь</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Пользователь,<br />взаимодействующий с системой.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    13("<div style='font-weight: bold'>MinIO</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div><div style='font-size: 80%; margin-top:10px'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 13 fill:#1168bd,stroke:#0b4884,color:#ffffff
    2("<div style='font-weight: bold'>Photo_platform</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 2 fill:#1168bd,stroke:#0b4884,color:#ffffff

    13-. "<div>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->2
    2-. "<div>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->13
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
    13("<div style='font-weight: bold'>MinIO</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div><div style='font-size: 80%; margin-top:10px'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 13 fill:#1168bd,stroke:#0b4884,color:#ffffff

    subgraph 2 ["Photo_platform"]
      style 2 fill:#ffffff,stroke:#0b4884,color:#0b4884

      11("<div style='font-weight: bold'>База данных</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 11 fill:#438dd5,stroke:#2e6295,color:#ffffff
      3("<div style='font-weight: bold'>UI платформы</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 3 fill:#438dd5,stroke:#2e6295,color:#ffffff
      6("<div style='font-weight: bold'>API Gateway</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 6 fill:#438dd5,stroke:#2e6295,color:#ffffff
    end

    3-. "<div>Передает данные</div><div style='font-size: 70%'></div>" .->6
    6-. "<div>Сохраняет данные индексации</div><div style='font-size: 70%'></div>" .->11
    13-. "<div>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->3
    6-. "<div>Отображение фотографий</div><div style='font-size: 70%'></div>" .->3
    6-. "<div>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->13
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
    13("<div style='font-weight: bold'>MinIO</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div><div style='font-size: 80%; margin-top:10px'>Внешнее хранилище,<br />совместимое с протоколом S3.</div>")
    style 13 fill:#1168bd,stroke:#0b4884,color:#ffffff

    subgraph 6 ["API Gateway"]
      style 6 fill:#ffffff,stroke:#2e6295,color:#2e6295

      7("<div style='font-weight: bold'>Auth Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 7 fill:#85bbf0,stroke:#5d82a8,color:#000000
      8("<div style='font-weight: bold'>User Profile Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 8 fill:#85bbf0,stroke:#5d82a8,color:#000000
      9("<div style='font-weight: bold'>Photo Service</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 9 fill:#85bbf0,stroke:#5d82a8,color:#000000
    end

    13-. "<div>Предоставляет фотографии</div><div style='font-size: 70%'></div>" .->3
    3-. "<div>Запрос на получение<br />пользователя</div><div style='font-size: 70%'></div>" .->7
    7-. "<div>Получение и обновления<br />информации о пользователе</div><div style='font-size: 70%'></div>" .->8
    8-. "<div>Получение информации о<br />фотографиях пользователя</div><div style='font-size: 70%'></div>" .->9
    3-. "<div>Запрос на отображение фото</div><div style='font-size: 70%'></div>" .->9
    9-. "<div>Отображение фотографий</div><div style='font-size: 70%'></div>" .->3
    9-. "<div>Загружает фотографии в<br />хранилище</div><div style='font-size: 70%'></div>" .->13
    9-. "<div>Получает данные о<br />пользователе, который<br />загружает фотографию</div><div style='font-size: 70%'></div>" .->8
  end
```
