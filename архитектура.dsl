workspace {
    model {
        user = person "Пользователь" "Пользователь, взаимодействующий с системой."

        photo = softwareSystem "Photo_platform" {
            frontend = container "UI платформы" {
                user -> this "Просматривает данные"
            }
            backend = container "API Gateway" {
                authService = component "Auth Service"
                userProfileService = component "User Profile Service"
                photoService = component "Photo Service"
                likeService = component "Like Service"
                friendService = component "Friend Service"
                redisCache = component "Redis Cache" "Служит для кэширования данных."
                frontend -> this "Передает данные"
            }
            db = container "База данных" {
                backend -> this "Сохраняет данные индексации"
            }
        }
        
        MinIO = softwareSystem "MinIO" {
            description "Внешнее хранилище, совместимое с протоколом S3."
            this -> frontend "Предоставляет фотографии"
        }

        frontend -> authService "Запрос на получение пользователя"
        authService -> userProfileService "Получение и обновления информации о пользователе"
        userProfileService -> photoService "Получение информации о фотографиях пользователя"
        frontend -> photoService "Запрос на отображение фото"
        photoService -> frontend "Отображение фотографий"
        photoService -> MinIO "Загружает фотографии в хранилище"
        photoService -> userProfileService "Получает данные о пользователе, который загружает фотографию"

        likeService -> photoService "Получение данных о фотографии"
        likeService -> friendService "Проверка, является ли владелец фотографии другом"
        likeService -> userProfileService "Получение данных о пользователе, который ставит лайк"

        frontend -> likeService "Запрос на добавление лайка"
        frontend -> friendService "Запрос на управление друзьями"
        friendService -> userProfileService "Получение и обновление данных о друзьях"

        // Кэширование с помощью Redis
        userProfileService -> redisCache "Кэширование информации о пользователе"
        photoService -> redisCache "Кэширование фотографий"
        likeService -> redisCache "Кэширование данных о лайках"
    }
    
    views {
        systemContext photo {
            include *
            autolayout lr
        }
        
        container photo {
            include *
            autolayout lr
        }
        
        component backend {
            include *
            autolayout bt
        }
        theme default
    }
}
