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
        
        // Связи между сервисами
        frontend -> authService "Запрос на получение пользователя"
        authService -> userProfileService "Получение и обновления информации о пользователе"
        userProfileService -> photoService "Получение информации о фотографиях пользователя"
        
        
        frontend -> photoService "Запрос на отображение фото"
        photoService -> frontend "Отображение фотографий"
        photoService -> MinIO "Загружает фотографии в хранилище"
        photoService -> userProfileService "Получает данные о пользователе, который загружает фотографию"

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
