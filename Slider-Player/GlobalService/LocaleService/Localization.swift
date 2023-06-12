//
//  Localization.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 04.10.2024.
//
//MARK: - Localization for English - Russian

extension String {
    static let russian = "Русский"
    static let english = "English"
    static let ruLocale = "ru"
    static let enLocale = "en"
    
    static var localeItem: Self { localeRu ? "Выбор языка приложения" : "Choice of application language"}
    
    //MARK: - LaunchView
    static var start: Self { localeRu ? "Старт" : "Start" }
    static var profile: Self { localeRu ? "Профиль" : "Profile"}
    static var profileSettings: Self { localeRu ? "Настройки профиля и приложения" : "Profile and application settings" }
    static var tryAutorization: Self { localeRu ? "Для старта необходима авторизация" : "To start try authorization" }
    static var passAutorization: Self { localeRu ? "Авторизация успешно пройдена" : "Authorization successfully completed" }

    //MARK: - ProfileSettings
    static let enFeed = "Feed"
    static let ruFeed = "Лента"
    static let enQuakes = "Quakes"
    static let ruQuakes = "Землятрясения"
    static let enFlexible = "Flexible"
    static let ruFlexible = "Гибкая"
    static let enAdaptive = "Adaptive"
    static let ruAdaptive = "Адаптивная"
    
    static var menuItemFeed: Self { localeRu ? .ruFeed : .enFeed}
    static var menuItemQuakes: Self { localeRu ? .ruQuakes : .enQuakes}
    static var gridFlexible: Self { localeRu ? .ruFlexible : .enFlexible}
    static var gridAdaptive: Self { localeRu ? .ruAdaptive : .enAdaptive}
    static var jpegCompression: Self { localeRu ? "jpeg Сжатие" : "jpeg Compression" }

    
    //MARK: - Authorization + Settings
    static var autorization: Self { localeRu ? "Авторизация" : "Authorization"}
    static var login: Self { localeRu ? "Логин" : "Login" }
    static var enterLogin: Self { localeRu ? "Ввести логин" : "Enter Login" }
    static var swipeToEdit: Self { localeRu ? "Новый пароль ->" : "New password ->" }
    static var passwordText: Self { localeRu ? "Пароль" : "Password" }
    static var enterPassword: Self { localeRu ? "Ввести пароль" : "Enter password" }
    static var incorrect: Self { localeRu ? "Некорректны " : "Incorrect "}
    static var characters: Self { localeRu ? " символов  в " : " characters in "}
    static var tryAgain: Self { localeRu ? "Повторите заново!" : "Try again!"}
    static var editPassword: Self { localeRu ? "Изменить пароль" : "Edit Password"}
    static var enterNewPassword: Self { localeRu ? "Введите новый пароль" : "Enter new password"}
    static var alertText: Self { localeRu ? "Неверный пароль или пустой логин, повторите заново!" : "Incorrect Password or Login is empty, try again!" }
    static var firstName: Self { localeRu ? "Имя: " : "First Name: " }
    static var enterFirstName: Self { localeRu ? "Введите Имя" : "Enter First Name" }
    static var lastName: Self { localeRu ? "Фамилия: " : "Last Name: " }
    static var enterLastName: Self { localeRu ? "Введите Фамилию" : "Enter Last Name" }
    static var addInfo: Self { localeRu ? "Дополнительная информация" : "Additional information" }
    static var enterAddInfo: Self { localeRu ? "Введите информацию" : "Enter info" }
    static var enterMail: Self { localeRu ? "Введите E-mail" : "Enter E-mail" }
    static var homePage: Self { localeRu ? "Начальная страница" : "Home page" }
    static var settings: Self { localeRu ? "Настройки" : "Settings"}
    static var rington: Self { localeRu ? "Рингтон" : "Rington"}
    static var privateAccount: Self { localeRu ? "Личный аккаунт" : "Private account"}
    static var isActive: Self { localeRu ? " aктивен" : " is active"}
    static var pianoKeyboards: Self { localeRu ? "Всего клавиатур" : "Piano keyboards"}
    static var pianoKeys: Self { localeRu ? "Всего клавиш" : "Piano keys"}
    static var gridColumns: Self { localeRu ? "Кол-во столбцов" : "Grid columns"}
    static var gridMode: Self { localeRu ? "Вид сетки" : "Grid mode"}
    static var menuItem: Self { localeRu ? "Mеню" : "Choice Menu"}
    static var more: Self { localeRu ? "Ещё" : "More"}
    static var references: Self { localeRu ? "Ссылки" : "References"}
    static var site: Self { localeRu ? "Сайт" : "Site"}
    static var eMail: Self { localeRu ? "Почта" : "E-mail"}

    
    //MARK: - TabView
    static var mainMenu: Self { localeRu ? "Главное меню" : "Main Menu"}
//    static var subMenu: Self { localeRu ? "Ещё меню" : "More menu"}
    static var map: Self { localeRu ? "Карта" : "Map"}
    static var playerTitle: Self { localeRu ? "Звуки" : "Sounds"}
    static var albumTitle: Self { localeRu ? "Альбом" : "Album"}
    static var usefulTitle: Self { localeRu ? "Полезное" : "Useful"}
    static var back: Self { localeRu ? "Назад" : "Back"}
    
    //MARK: - Album
    static var object: Self { localeRu ? "Объект" : "Object"}
    static var imageCell: Self { localeRu ? "Фото объект" : "Image Cell"}
    static var images: Self { localeRu ? "фото" : "images"}
    static var imagesGallery: Self { localeRu ? "Галерея" : "Images Gallery"}
    static var title: Self { localeRu ? "Название" : "Title"}
    static var address: Self { localeRu ? "Адрес" : "Address"}
    static var latitude: Self { localeRu ? "Широта" : "Latitude"}
    static var longitude: Self { localeRu ? "Долгота" : "Longitude"}
    static var altitude: Self { localeRu ? "Высота" : "Altitude"}
    static var degrees: Self { localeRu ? "Градусы" : "Degrees"}
    static var gesture: Self { localeRu ? "Применить Жесты" : "Apply Gesture"}
    static var column: Self { localeRu ? "Столбец" : "Column"}
    static var column2s4: Self { localeRu ? "Столбца" : "Columns"}
    static var columns: Self { localeRu ? "Столбцов" : "Columns"}
    static var actionText: Self { localeRu ? "Удалить все объекты?" : "Delete all objects?"}
    static var actionMessage: Self { localeRu ? "Это действие нельзя отменить!" : "This action cannot be undone!"}
    static var actionOK: Self { localeRu ? "Хорошо" : "OK"}
    static var photoFromApp: Self { localeRu ? "Фотография из Приложения" : "Photo from App"}
    static var date: Self { localeRu ? "Дата:" : "Date:"}
    
    //MARK: - Speech recognizer
    static var message: Self { localeRu ? "Сообщение" : "Message"}
    static var speechRecognizer: Self { localeRu ? "Речь -> Текст" : "Speech recognizer"}
    static var app: Self { localeRu ? "Приложение" : "App"}
    static var recognizing: Self { localeRu ? "Распознавание..." : "Recognizing..."}
    static var turnOnMicMessage: Self { localeRu ? "Включите микрофон и диктуйте сообщение" : "Turn on microphone and dictate message"}
    static var starting: Self { localeRu ? "Начато" : "Starting"}
    
    //MARK: - Player - Recorder
    static var audio: Self { localeRu ? "Аудио" : "Audio"}
    static var piece: Self { localeRu ? "Пьеса" : "Piece"}
    static var progress: Self { localeRu ? "Прошло" : "Progress"}
    static var player: Self { localeRu ? "Плеер" : "Player"}
    static var album: Self { localeRu ? "Альбом" : "Album"}
    static var duration: Self { localeRu ? "Длительность" : "Duration"}
    static var startPlayer: Self { localeRu ? "Начать играть" : "Start playing"}
    static var error: Self { localeRu ? "Ошибка" : "Error"}
    static var errorMessage: Self { localeRu ? "Разрешение на запись отклонено" : "Record permission status is denied"}
    static var exportTrack: Self { localeRu ? "Экспорт аудио из Slider-player App" : "Export audio from Slider-player App"}
    static var playButton: Self { localeRu ? "Bключениe воспроизведения" : "Play button" }
    static var pauseButton: Self { localeRu ? "Остановка воспроизведения" : "Pause button" }
    
    //MARK: - Piano + Music
    static var pianoTitle: Self {localeRu ? "Пиано + Запись" : "Player + Record"}
    static var piano: Self {localeRu ? "Пиано" : "Piano"}
    static var musicList: Self {localeRu ? "Список пьес" : "Music List"}
    static var copyFile: Self {localeRu ? "Пьесы скопированы в список Аудио" : "Pieces copied to Audio list"}
    static var searchRequest: Self {localeRu ? "Введите автора или название песни" : "Enter author or song name"}
    static var itunesList: Self {localeRu ? "Список iTunes" : "iTunes List"}
    static var pieces: Self {localeRu ? "пьес(ы)" : "pieces"}
    
    //MARK: - Quakes
    static var selected: Self {localeRu ? "Выбрано" : "Selected"}
    static var quakePlace: Self {localeRu ? "Эпицентр" : "Quake place"}
    static var quakes: Self {localeRu ? "землетрясений(я)" : "quakes"}
    static var capQuakes: Self {localeRu ? .ruQuakes : .enQuakes}
    
    //MARK: - Examples
    static var webUrlExample = "https://www.apple.com"
    static var weather: Self {localeRu ? "Погода" : "Weather"}
    static var currentLocation: Self {localeRu ? "Текущее место" : "Current location"}
    static var mapSearch: Self {localeRu ? "Поиск на карте" : "Map search"}
    static var toggleLights: Self {localeRu ? "Переключить день/ночь" : "Toggle light"}
    static var gestureExperience: Self {localeRu ? "Эксперименты с жестами" : "Gesture experience"}
    static var sceneStorage: Self {localeRu ? "Сохранение сцен" : "Scene storage"}
    static var navigationSplit: Self {localeRu ? "Разделение навигации" : "Navigation split"}
    static var showRecipes: Self {localeRu ? "Показать рецепты" : "Show recipes"}
    static var capturingPhoto: Self {localeRu ? "Съёмка фото" : "Capturing photo"}
    static var turnOff: Self {localeRu ? "Выключить свет!" : "Turn the lights off!"}
    static var turnOn: Self {localeRu ? "Включить свет!" : "Turn the lights on!"}
    static var selectMovie: Self {localeRu ? "Выберите видео" : "Select movie"}
    static var selectImage: Self {localeRu ? "Выберите изображение" : "Select image"}
    static var importFailed: Self {localeRu ? "Не удалось импортировать файл" : "Failed to import file"}
    static var loading: Self {localeRu ? "Загрузка..." : "Loading..."}
    static var cancel: String {localeRu ? "Отмена" : "Cancel"}
    
    //MARK: - QR Code
    static var webContent: Self {localeRu ? "WEB запрос" : "WEB content"}
    static var documentTitle: Self {localeRu ? "Заголовок документа" : "Document title"}
    static var qrCodeGenerator: Self {localeRu ? "QR-код генератор" : "QR Code Generator"}
    static var qrCodeScanner: Self {localeRu ? "QR-код сканер" : "QR Code Scanner"}
    static var qrCodeNotRecognized: Self {localeRu ? "QR-код не распознан" : "QR Code not recognized"}
    static var enterUrl: Self {localeRu ? "Введите URL" : "Enter URL"}
    static var generate: Self {localeRu ? "Создать" : "Generate"}
    static var success: Self {localeRu ? "Успешно!" : "Success!"}
    static var successMessage: Self {localeRu ? "Код успешно сохранен в фотобиблиотеку" : "Code successfully saved to photo library"}
    static var oops: Self {localeRu ? "Ой!" : "Oops!"}
    static var oopsMessage: Self {localeRu ? "Код не сохранен в фотобиблиотеку" : "Code not saved to photo library"}
    static var oopsMessage2: Self {localeRu ? "Это приложение нуждается в разрешении добавить фотографии в вашу фотобиблиотеку." : "This app needs permission to add photos to your library."}
    static var openSettings: Self {localeRu ? "Открыть настройки" : "Open settings"}
    static var qrCodeFor: Self {localeRu ? "Код для" : "QR Code for"}
    static var createQrCode: Self {localeRu ? "Создать свой собственный QR-код" : "Create your own QR-code"}
    static var cannotSaveImage: Self {localeRu ? "Невозможно сохранить пустое изображение" : "Cannot save nil QR code image"}
    static var scanQR: Self {localeRu ? "Сканируйте QR-код" : "Scan QR code"}
    
    //MARK: - Bubble level
    static var levelDetector: Self {localeRu ? "Уровнемер" : "Level Detector"}
    static var bubbleSurfaceLevelMeter: Self {localeRu ? "Измерение уровня поверхности" : "Bubble surface level meter"}
    static var bubbleLevelMeter: Self {localeRu ? "Измеритель уровня" : "Bubble level meter"}
    static var horizontal: Self {localeRu ? "Горизонталь" : "Horizontal"}
    static var vertical: Self {localeRu ? "Вертикаль" : "Vertical"}
    
    //MARK: - Photo & Video
    static var files: Self {localeRu ? "Файл (а/ов)" : "Files"}
    static var photo: Self {localeRu ? "Фото" : "Photo"}
    static var movie: Self {localeRu ? "Видео" : "Movie"}
    static var movies: Self {localeRu ? "Видео" : "Movies"}
    static var gallery: Self {localeRu ? "Галерея" : "Gallery"}
    static var galleryFiles: Self {localeRu ? "Файлы галереи" : "Gallery files"}
    static var favorite: Self {localeRu ? "Избранное" : "Favorite"}
    static var favoriteLocations: Self {localeRu ? "Избранные местоположения" : "Favorite locations"}
    static var capture: Self {localeRu ? "Снять фото" : "Capture photo"}
    static var captureAndSave: Self {localeRu ? "Снять и сохранить фото" : "Capture and save photo"}
    static var saveToLibrary: Self {localeRu ? "Фото будет сохранено в фотоальбоме" : "Photo will be saved in photo library"}
    static var cancelToSave: Self {localeRu ? "Отмена сохранения в фотоальбоме" : "Cancel saving in photo library"}
    
    //MARK: - ToolbarContent
    static var delete: Self {localeRu ? "Удалить" : "Delete"}
    static var refresh: Self {localeRu ? "Обновить" : "Refresh"}
    static var checkingFor: Self {localeRu ? "Проверка для" : "Checking for"}
    static var updated: Self {localeRu ? "Обновлено" : "Updated"}
    
    //MARK: - Map
    static var location: Self {localeRu ? "Местоположение" : "Location"}
    static var unknownLocation: Self {localeRu ? "Неизвестное местоположение" : "Unknown location"}
    static var distance: Self {localeRu ? "Расстояние:" : "Distance:"}
    static var time: Self {localeRu ? "Время:" : "Time:"}
    static var parking: Self {localeRu ? "Парковка" : "Parking"}
    static var market: Self {localeRu ? "Торговля" : "Market"}
    static var museum: Self {localeRu ? "Музей" : "Museum"}
    static var restaurant: Self {localeRu ? "Ресторан" : "Restaurant"}
    static var hotel: Self {localeRu ? "Отель" : "Hotel"}
    static var playground: Self {localeRu ? "Площадка" : "Playground"}
    static var school: Self {localeRu ? "Школа" : "School"}
    static var beach: Self {localeRu ? "Пляж" : "Beach"}
    static var newRegion: Self {localeRu ? "Новый регион" : "New region"}
    static var enterPointOfInterest: Self {localeRu ? "Ввести точку интереса" : "Enter Point of interest"}
    static var span: Self {localeRu ? "Область: " : "Span: "}
    static var enterDegrees: Self {localeRu ? "Введите градусы" : "Enter degrees"}
    static var addressFromMarkerLocation: Self {localeRu ? "Адрес из местоположения" : "Address from marker location"}
    static var newMap: Self {localeRu ? "Новая карта" : "New map"}
    static var withSearchPlaces: Self {localeRu ? " с поиском мест" : " with search places"}
    
    //MARK: - Weather
    static var clouds: Self {localeRu ? "Облака" : "Clouds"}
    static var precipitation: Self {localeRu ? "Осадки" : "Precip"}
    static var wind: Self {localeRu ? "Ветер" : "Wind"}
    static var humidity: Self {localeRu ? "Влажность" : "Humidity"}
    static var pressure: Self {localeRu ? "Давление" : "Pressure"}
    static var sunrise: Self {localeRu ? "Восход" : "Sunrise"}
    static var sunset: Self {localeRu ? "Заход" : "Sunset"}
    static var now: Self {localeRu ? "Сейчас" : "Now"}
    static var feelsLike: Self {localeRu ? "Ощущается как" : "Feels like"}
    static var temperature: Self {localeRu ? "Температура" : "Temperature"}
    static var tempCell: Self {localeRu ? "Темп-ра" : "Temp-re"}
    static var maxTemp: Self {localeRu ? "Макс темп" : "Max temp"}
    static var minTemp: Self {localeRu ? "Мин темп" : "Min temp"}
    static var visibility: Self {localeRu ? "Видимость" : "Visibility"}
    static var uvIndex: Self {localeRu ? " UV Индекс" : "UV Index"}
    static var maxWind: Self {localeRu ? "Макс ветер" : "Max wind"}
    static var moonrise: Self {localeRu ? "Восход Луны" : "Moonrise"}
    static var moonset: Self {localeRu ? "Заход Луны" : "Moonset"}
    static var totalPrecpt: Self {localeRu ? "Всего осадков" : "Total precpt"}
    static var precipMm: Self {localeRu ? "Осадки" : "Precip"}
    static var totalSnow: Self {localeRu ? "Всего снега" : "Total snow"}
    static var rainChance: Self {localeRu ? "Шанс осадков" : "Rain chance"}
    static var snowChance: Self {localeRu ? "Шанс снега" : "Snow chance"}
    static var snowCm: Self {localeRu ? "Снег" : "Snow"}
    static var dayCell: Self {localeRu ? "День, час" : "Day, hour"}
    static var description: Self {localeRu ? "Описание" : "Description"}
    static var forecast5Days: Self {localeRu ? "Прогноз на 5 дней" : "Forecast for 5 days"}
    static var dateFormatMoon: Self {localeRu ? "HH:mm" : "h:mm a"}
    static var dateFormatDayHour: Self {localeRu ? "E H:mm" : "E h a"}
    static var dateFormatDayDateHour: Self  {localeRu ? "EE, dd MMMM yyyy, HH:mm" : "EE, dd MMMM yyyy, h:mm a"}
    
    //MARK: - News
    static var news: Self {localeRu ? "Новости" : "News"}
    static var topNews: Self {localeRu ? "Главное" : "Top news"}
    static var allNews: Self {localeRu ? "Все новости" : "All news"}
    static var category: Self {localeRu ? "Категория" : "Category"}
    static var query: Self {localeRu ? "Поиск" : "Query"}
    
    //MARK: - Measures
    static var sec: Self {localeRu ? "с" : "s"}
    static var mps: Self {localeRu ? "м/с" : "mps"}
    static var kph: Self {localeRu ? "км/ч" : "kph"}
    static var mm: Self {localeRu ? "мм" : "mm"}
    static var km: Self {localeRu ? "км" : "km"}
    static var mb: Self {localeRu ? "мб" : "mb"}
    static var min: Self {localeRu ? "мин" : "min"}
    static var sm: Self {localeRu ? "см" : "sm"}
}
 
