# IMDUMB 🎬

Aplicación Flutter para explorar y descubrir películas usando la API de The Movie Database (TMDB).

## 📋 Resumen del Proyecto

IMDUMB es una aplicación móvil desarrollada en Flutter que permite a los usuarios:
- Explorar películas populares, en estreno y mejor valoradas
- Navegar por categorías de géneros
- Ver detalles completos de películas incluyendo imágenes, descripción en HTML, y elenco
- Recomendar películas con comentarios personalizados

La aplicación sigue principios de Clean Architecture y SOLID para garantizar un código mantenible, escalable y de alta calidad.

## 🏗️ Arquitectura

El proyecto utiliza **Clean Architecture** con separación clara de responsabilidades en tres capas:

```
lib/
├── core/                    # Capa core compartida
│   ├── config/             # Configuraciones (Schema/Targets)
│   ├── injection/          # Dependency Injection
│   ├── routes/             # Navegación
│   ├── services/           # Servicios compartidos (Network)
│   ├── theme/              # Tema y estilos
│   └── utils/              # Utilidades y extensiones
│
└── features/               # Features modulares
    ├── home/               # Pantalla principal
    ├── movie_detail/       # Detalle de película
    ├── movies_list/        # Lista de películas
    └── splash/             # Pantalla de inicio
        │
        └── [feature]/
            ├── data/       # Capa de datos
            │   ├── datasource/    # Fuentes de datos (Network/Local)
            │   ├── models/        # Modelos de datos
            │   ├── mappers/       # Mapeadores Model -> Entity
            │   └── repository/    # Implementación de repositorios
            │
            ├── domain/     # Capa de dominio
            │   ├── entities/      # Entidades de negocio
            │   ├── repository/    # Interfaces de repositorios
            │   └── use_cases/     # Casos de uso
            │
            └── presentation/  # Capa de presentación
                ├── bloc/         # State Management (BLoC)
                ├── widgets/      # Widgets reutilizables
                └── [feature]_screen.dart
```

### Principios SOLID Aplicados

1. **Single Responsibility Principle (SRP)**: Cada clase tiene una única responsabilidad
   - UseCases: encapsulan lógica de negocio específica
   - Blocs: gestionan estado de una feature específica
   - DataSources: manejan comunicación con fuentes de datos

2. **Open/Closed Principle (OCP)**: Abierto para extensión, cerrado para modificación
   - `ApiServices` interface permite cambiar implementaciones sin modificar código cliente
   - `DioApiServicesImpl` puede ser reemplazado por otra implementación HTTP

3. **Dependency Inversion Principle (DIP)**: Dependencias apuntan a abstracciones
   - Repositorios dependen de interfaces, no de implementaciones concretas
   - UseCases dependen de interfaces de repositorios
   - Ver comentarios en código para ejemplos específicos

## 🛠️ Tech Stack y Dependencias

### Flutter
- **Versión**: SDK ^3.10.1

### Dependencias Principales

```yaml
dependencies:
  flutter_bloc: ^9.1.1          # State Management
  dio: ^5.9.0                    # HTTP Client
  get_it: ^9.2.0                 # Dependency Injection
  equatable: ^2.0.8              # Value Equality
  dartz: ^0.10.1                 # Functional Programming
  auto_route: ^11.1.0            # Navigation
  cached_network_image: ^3.4.1   # Image Caching
  carousel_slider: ^5.1.1        # Image Carousel
  shimmer: ^3.0.0                # Loading Animation
  iconsax: ^0.0.8                # Custom Icons
  flutter_html: ^3.0.0-beta.2    # HTML Rendering
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_lints: ^6.0.0
  auto_route_generator: ^10.4.0
  build_runner: ^2.10.4
```

## 🚀 Cómo Ejecutar el Proyecto

### Requisitos Previos

- Flutter SDK ^3.10.1
- Dart SDK compatible
- Android Studio / Xcode (para desarrollo móvil)
- VS Code o Android Studio (IDE recomendado)

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd imdumb
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**

   El proyecto usa `dart-define` para configuraciones. Crea un archivo `env.json` en la raíz del proyecto:
   
   ```json
   {
     "base_url": "https://api.themoviedb.org/3",
     "access_token": "tu_access_token_aqui"
   }
   ```

   O configura directamente al ejecutar:
   ```bash
   flutter run --dart-define=base_url=https://api.themoviedb.org/3 --dart-define=access_token=tu_token
   ```

4. **Generar código (si es necesario)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

   O usando el archivo de configuración:
   ```bash
   flutter run --dart-define-from-file=env.json
   ```

### Configuración de VS Code

El proyecto incluye configuración de launch en `.vscode/launch.json` que usa automáticamente `env.json`.

## 🔧 Schema/Targets (Configuraciones)

El proyecto utiliza **Schema/Targets** para manejar configuraciones mediante `dart-define`:

- **Desarrollo**: Usa `env.json` para configuraciones locales
- **Staging/Producción**: Variables de entorno configuradas en CI/CD

La clase `AppConfig` centraliza todas las configuraciones:
- `baseUrl`: URL base de la API
- `accessToken`: Token de autenticación
- `httpTimeout`: Timeout para peticiones HTTP
- `defaultLanguage`: Idioma por defecto

Ver `lib/core/config/app_config.dart` para más detalles.

## 🔥 Configuración de Firebase

El proyecto utiliza **Firebase** para Remote Config y Analytics.

### Configuración Inicial

1. **Crear proyecto en Firebase Console**
   - Ve a [Firebase Console](https://console.firebase.google.com/)
   - Crea un nuevo proyecto o selecciona uno existente

2. **Agregar apps Android e iOS**
   - En Firebase Console, ve a "Agregar app"
   - Selecciona Android y completa el formulario:
     - **Package name**: `com.example.imdumb` (verifica en `android/app/build.gradle`)
     - Descarga `google-services.json`
   - Repite para iOS:
     - **Bundle ID**: `com.example.imdumb` (verifica en `ios/Runner.xcodeproj`)
     - Descarga `GoogleService-Info.plist`

3. **Colocar archivos de configuración**
   - **Android**: Coloca `google-services.json` en `android/app/`
   - **iOS**: Coloca `GoogleService-Info.plist` en `ios/Runner/`

4. **Configurar Remote Config**
   - En Firebase Console, ve a "Remote Config"
   - Agrega parámetros según necesites
   - Ejemplo: `welcome_message` (String) con valor por defecto
   - Publica los cambios

### Dependencias Firebase

El proyecto utiliza las siguientes dependencias de Firebase:

```yaml
firebase_core: ^4.3.0
firebase_remote_config: ^6.1.3
firebase_analytics: ^12.1.0
```

### Inicialización

Firebase se inicializa en `lib/main.dart`:

```dart
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

El archivo `lib/firebase_options.dart` se genera automáticamente al configurar Firebase con FlutterFire CLI.

### Remote Config

El servicio de Remote Config está implementado siguiendo principios SOLID:

- **Interfaz abstracta**: `RemoteConfigService` (DIP)
- **Implementación**: `RemoteConfigServiceImpl` (SRP)
- **Inyección de dependencias**: Registrado en `AppInjection`

La pantalla de Splash lee valores de Remote Config y los guarda en almacenamiento local.

### Almacenamiento Local

El proyecto utiliza **SharedPreferences** para almacenamiento local simple, implementado mediante:

- **Interfaz abstracta**: `LocalStorageService` (DIP)
- **Implementación**: `SharedPreferencesServiceImpl` (SRP, OCP)

Esta arquitectura permite cambiar fácilmente a otras implementaciones (flutter_secure_storage, Hive, SQFlite) sin modificar el código cliente.

## 🔌 Endpoints Utilizados

La aplicación consume la **API de The Movie Database (TMDB)**:

### Base URL
```
https://api.themoviedb.org/3
```

### Endpoints Principales

- `GET /movie/popular` - Películas populares
- `GET /movie/now_playing` - Películas en estreno
- `GET /movie/top_rated` - Películas mejor valoradas
- `GET /genre/movie/list` - Lista de géneros
- `GET /discover/movie?with_genres={genreId}` - Películas por género
- `GET /movie/{movieId}` - Detalle de película
- `GET /movie/{movieId}/images` - Imágenes de película
- `GET /movie/{movieId}/credits` - Créditos (cast) de película
- `GET /credit/{creditId}` - Detalle de crédito

### Autenticación

La API requiere un token de acceso (Bearer Token) que debe configurarse en las variables de entorno.

Para obtener un token de TMDB:
1. Crea una cuenta en [TMDB](https://www.themoviedb.org/)
2. Genera un API Key desde tu perfil
3. Usa el token como `access_token` en la configuración

## 📱 Características Principales

### Pantalla Principal (Home)
- Carrusel de películas populares
- Secciones: Now Playing, Top Rated, Películas por Género
- Drawer con navegación por géneros
- Scroll infinito en listas horizontales
- Imagen de fondo animada basada en película popular

### Pantalla de Detalle
- Carrusel de imágenes en el AppBar
- Título, calificación, duración, géneros
- Descripción en HTML
- Lista horizontal de actores (cast)
- Botón fijo "Recomendar"

### Modal de Recomendación
- Muestra detalles de la película
- Campo de texto para comentarios
- Confirmación con mensaje de éxito

### Lista de Películas
- Vista en grid
- Filtrado por categoría o género
- Scroll infinito
- Navegación al detalle

## 🏛️ Principios SOLID Documentados

El código incluye documentación explícita de principios SOLID en ubicaciones clave:

1. **`lib/core/services/network/api_services.dart`**: Dependency Inversion Principle
2. **`lib/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart`**: Single Responsibility Principle
3. **`lib/core/services/network/dio_services_impl.dart`**: Open/Closed Principle
4. **`lib/features/home/presentation/bloc/orchestrator/home_orchestrator_bloc.dart`**: Single Responsibility Principle

Ver comentarios en el código para más detalles.

## 📝 Estado del Proyecto

### ✅ Implementado
- Clean Architecture completa
- BLoC Pattern para state management
- Consumo de API REST con Dio
- Pantallas principales funcionales
- Navegación con auto_route
- HTML rendering para descripciones
- Schema/Targets para configuraciones
- Documentación SOLID

### 🔄 Pendiente
- Tests unitarios e integración

## 📄 Licencia

Este proyecto es una prueba técnica y está destinado únicamente para evaluación.

## 👨‍💻 Autor

Desarrollado como parte de una prueba técnica para el puesto de Desarrollador Flutter Senior.
