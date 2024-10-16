# TestSberTech
Тестовое задание для команды Сбертеха 


## Архитектура решения в нотации C4 

### Уровень системы
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
