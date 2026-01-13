# IMDUMB

Aplicación Flutter para explorar y descubrir películas usando la API de The Movie Database (TMDB).

## 🎥 Video de Demostración

**Ver la aplicación en acción:**

<div align="center">

<!-- Intento de reproductor embebido - GitHub puede bloquear iframes por seguridad -->
<iframe 
  width="560" 
  height="315" 
  src="https://drive.google.com/file/d/1kIsLutqLZHdwF64WpX2xMg_SYSHaloW_/preview" 
  frameborder="0" 
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
  allowfullscreen
  style="max-width: 100%; height: auto; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
</iframe>

</div>

<div align="center" style="margin-top: 20px;">
  <a href="https://drive.google.com/file/d/1kIsLutqLZHdwF64WpX2xMg_SYSHaloW_/view?usp=sharing&t=115">
    <img src="https://img.shields.io/badge/▶️-Reproducir%20Video%20Completo-FF0000?style=for-the-badge&logo=google-drive" alt="Reproducir Video Completo" />
  </a>
  <a href="https://drive.google.com/file/d/1JLzSzYA-smK34KZ1JKMBcdQ--nOwK0xZ/view?usp=drive_link">
    <img src="https://img.shields.io/badge/📱-Descargar%20APK-00C853?style=for-the-badge&logo=android" alt="Descargar APK" />
  </a>
</div>

> **Nota sobre el reproductor:** Si el reproductor embebido no se muestra (GitHub bloquea iframes por seguridad), haz clic en el botón "Reproducir Video Completo" arriba para ver el video en Google Drive.

**Enlaces directos:**
- 👉 [Ver video completo de demostración](https://drive.google.com/file/d/1kIsLutqLZHdwF64WpX2xMg_SYSHaloW_/view?usp=sharing&t=115)
- 📱 [Descargar APK para Android](https://drive.google.com/file/d/1JLzSzYA-smK34KZ1JKMBcdQ--nOwK0xZ/view?usp=drive_link)

---

## Resumen del Proyecto

IMDUMB es una aplicación móvil desarrollada en Flutter que permite a los usuarios:
- Explorar películas populares, en estreno y mejor valoradas
- Navegar por categorías de géneros
- Ver detalles completos de películas incluyendo imágenes, descripción en HTML, y elenco
- Recomendar películas con comentarios personalizados

La aplicación sigue principios de Clean Architecture y SOLID para garantizar un código mantenible, escalable y de alta calidad.

## Arquitectura

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
    ├── search/             # Búsqueda de películas
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
   - `CacheDatabaseService` permite cambiar entre SQLite y Drift sin modificar código cliente

3. **Dependency Inversion Principle (DIP)**: Dependencias apuntan a abstracciones
   - Repositorios dependen de interfaces, no de implementaciones concretas
   - UseCases dependen de interfaces de repositorios
   - Ver comentarios en código para ejemplos específicos

## Tech Stack y Dependencias

### Flutter y Dart
- **Flutter**: 3.38.5
- **Dart SDK**: 3.10.4 (compatible con ^3.10.1 especificado en pubspec.yaml)
- **Nota**: El proyecto usa FVM (Flutter Version Management) para gestionar versiones de Flutter

### Dependencias Principales

```yaml
dependencies:
  flutter_bloc: ^9.1.1          # State Management (BLoC)
  dio: ^5.9.0                    # HTTP Client (obligatorio)
  get_it: ^9.2.0                 # Dependency Injection
  equatable: ^2.0.8              # Value Equality
  dartz: ^0.10.1                 # Functional Programming
  auto_route: ^11.1.0            # Navigation
  cached_network_image: ^3.4.1   # Image Caching
  carousel_slider: ^5.1.1        # Image Carousel
  shimmer: ^3.0.0                # Loading Animation
  iconsax: ^0.0.8                # Custom Icons
  flutter_html: ^3.0.0-beta.2    # HTML Rendering
  firebase_core: ^4.3.0          # Firebase Core
  firebase_remote_config: ^6.1.3 # Firebase Remote Config
  firebase_analytics: ^12.1.0    # Firebase Analytics
  sqflite: ^2.3.3                # SQLite Database (Cache)
  shared_preferences: ^2.5.4      # Local Storage
  path_provider: ^2.1.4          # Path Provider
  path: ^1.9.1                   # Path utilities
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_lints: ^6.0.0
  auto_route_generator: ^10.4.0
  build_runner: ^2.7.1
  mocktail: ^1.0.4
  mockito: ^5.4.4
  bloc_test: ^10.0.0
  integration_test:
    sdk: flutter
```

## Cómo Ejecutar el Proyecto

### Requisitos Previos

- Flutter SDK 3.38.5 (o compatible con Dart 3.10.1 o superior)
- Dart SDK 3.10.4 (mínimo ^3.10.1 según pubspec.yaml)
- FVM (Flutter Version Management) - recomendado para gestionar versiones
- Android Studio / Xcode (para desarrollo móvil)
- VS Code o Android Studio (IDE recomendado)

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd imdumb
   ```

2. **Configurar FVM (si usas Flutter Version Management)**
   ```bash
   fvm install
   fvm use <version>
   ```
   O usar Flutter directamente si no usas FVM.

3. **Instalar dependencias**
   ```bash
   flutter pub get
   # O si usas FVM:
   fvm flutter pub get
   ```

3. **Configurar variables de entorno (OBLIGATORIO)**

   El proyecto usa `dart-define` para configuraciones. **DEBES crear un archivo `env.json` en la raíz del proyecto** antes de ejecutar la aplicación.
   
   **⚠️ IMPORTANTE:** El archivo `env.json` NO está incluido en el repositorio (está en `.gitignore` por seguridad). Debes crearlo localmente.
   
   **Crear archivo env.json:**
   
   Crea un archivo llamado `env.json` en la raíz del proyecto (al mismo nivel que `pubspec.yaml`) con el siguiente contenido:
   
   ```json
   {
     "base_url": "https://api.themoviedb.org/3",
     "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYTdjNDBiY2U5ZGM5ZjI2NzgzNjk3MTFkYjljOGI4MCIsIm5iZiI6MTc2ODE0NjIxMi44MjYsInN1YiI6IjY5NjNjNTI0MTVlYzViYjVhOGQxNTY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kHnfy-6OcsLm12sx9m4P7K8NyYOBWuGxsKvC8W-thsI"
   }
   ```
   
   **IMPORTANTE - Seguridad del Access Token:**
   
   - **Este token está incluido en el repositorio SOLO para fines de esta prueba técnica**
   - **En un proyecto real, NUNCA se debe incluir tokens o credenciales en el repositorio**
   - **Buenas prácticas de seguridad:**
     - Usar variables de entorno del sistema
     - Usar archivos `env` que estén en `.gitignore`
     - Usar servicios de gestión de secretos (AWS Secrets Manager, Google Secret Manager, etc.)
     - Usar CI/CD para inyectar credenciales de forma segura
   - **Este token será invalidado una vez finalizada la prueba técnica**
   - **Para producción, cada desarrollador debe obtener su propio token de TMDB**
   
   **Alternativa: Configuración directa en línea de comandos**
   
   Si prefieres no usar el archivo `env.json`, puedes pasar las variables directamente:
   ```bash
   flutter run --dart-define=base_url=https://api.themoviedb.org/3 --dart-define=access_token=tu_token
   # O si usas FVM:
   fvm flutter run --dart-define=base_url=https://api.themoviedb.org/3 --dart-define=access_token=tu_token
   ```
   
   **Nota sobre dart-define:**
   - `dart-define` permite pasar variables de entorno en tiempo de compilación
   - Estas variables se leen en `lib/core/config/app_config.dart` usando `String.fromEnvironment()`
   - El archivo `env.json` se usa con `--dart-define-from-file=env.json` para facilitar la configuración
   - VS Code está configurado para usar automáticamente `env.json` (ver `.vscode/launch.json`)

4. **Generar código (si es necesario)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   # O si usas FVM:
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Ejecutar la aplicación**
   ```bash
   flutter run
   # O si usas FVM:
   fvm flutter run
   ```

   O usando el archivo de configuración:
   ```bash
   flutter run --dart-define-from-file=env.json
   # O si usas FVM:
   fvm flutter run --dart-define-from-file=env.json
   ```

### Configuración de VS Code

El proyecto incluye configuración de launch para VS Code que usa automáticamente `env.json`.

**Estructura de archivos:**

El proyecto debe tener la siguiente estructura en la carpeta `.vscode`:

```
.vscode/
└── launch.json
```

**Ubicación del archivo:**
- **Carpeta**: `.vscode/` (en la raíz del proyecto, al mismo nivel que `pubspec.yaml`)
- **Archivo**: `launch.json` (dentro de la carpeta `.vscode/`)

**Contenido del archivo `.vscode/launch.json`:**

Este archivo configura las opciones de depuración para VS Code. Debe contener:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "imdumb",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define-from-file=env.json"
            ]
        },
        {
            "name": "imdumb (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "args": [
                "--dart-define-from-file=env.json"
            ]
        },
        {
            "name": "imdumb (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args": [
                "--dart-define-from-file=env.json"
            ]
        }
    ]
}
```

**Explicación de la configuración:**

- **`"version"`**: Versión del formato de configuración de VS Code (0.2.0)
- **`"configurations"`**: Array con las diferentes configuraciones de ejecución
- **`"name"`**: Nombre que aparece en el selector de configuración de VS Code
- **`"request"`**: Tipo de solicitud (`"launch"` para iniciar la aplicación)
- **`"type"`**: Tipo de depurador (`"dart"` para aplicaciones Flutter/Dart)
- **`"flutterMode"`**: Modo de Flutter (opcional: `"profile"` o `"release"`, por defecto es `"debug"`)

**Explicación de `args` (importante):**

- **`"args"`**: Array de argumentos que se pasan a Flutter al ejecutar la aplicación desde VS Code
- **`"--dart-define-from-file=env.json"`**: 
  - Indica a Flutter que lea las variables de entorno desde el archivo `env.json`
  - Este argumento debe estar en el array `args` para que VS Code use automáticamente las variables de entorno
  - Sin este argumento, VS Code no cargaría las variables de `env.json` y la app no podría conectarse a la API

**Ejemplo de cómo funciona `args`:**

Cuando presionas F5 o haces clic en "Run" en VS Code, internamente ejecuta el equivalente a:

```bash
flutter run --dart-define-from-file=env.json
```

El array `args` en `launch.json` es equivalente a pasar argumentos en la línea de comandos. Por ejemplo:

**En `launch.json`:**
```json
{
    "args": [
        "--dart-define-from-file=env.json"
    ]
}
```

**Equivale a ejecutar en terminal:**
```bash
flutter run --dart-define-from-file=env.json
```

**Si quisieras pasar múltiples argumentos, los agregarías así:**
```json
{
    "args": [
        "--dart-define-from-file=env.json",
        "--verbose",
        "--no-sound-null-safety"
    ]
}
```

**Equivalente en terminal:**
```bash
flutter run --dart-define-from-file=env.json --verbose --no-sound-null-safety
```

**Importante:** Cada elemento del array `args` es un argumento separado que se pasa a Flutter.

**Configuraciones disponibles:**

- **imdumb**: Modo debug (desarrollo) - Para desarrollo y depuración
- **imdumb (profile mode)**: Modo profile - Para análisis de rendimiento
- **imdumb (release mode)**: Modo release - Para pruebas de producción

**Importante:**
- Todas las configuraciones usan automáticamente el archivo `env.json` para las variables de entorno
- Si clonas el repositorio, el archivo `.vscode/launch.json` ya está incluido
- Si no usas VS Code, puedes ignorar esta configuración y usar los comandos de terminal directamente

## Schema/Targets (Configuraciones)

El proyecto utiliza **Schema/Targets** para manejar configuraciones mediante `dart-define`:

- **Desarrollo**: Usa `env.json` para configuraciones locales
- **Staging/Producción**: Variables de entorno configuradas en CI/CD

### Cómo Funciona dart-define

`dart-define` es una característica de Flutter que permite pasar variables de entorno en tiempo de compilación. Estas variables se leen usando `String.fromEnvironment()` o `bool.fromEnvironment()`.

**Proceso:**

1. **Definir variables en env.json:**
   ```json
   {
     "base_url": "https://api.themoviedb.org/3",
     "access_token": "tu_token_aqui"
   }
   ```

2. **Leer variables en código:**
   ```dart
   // En lib/core/config/app_config.dart
   static const String baseUrl = String.fromEnvironment('base_url');
   static const String accessToken = String.fromEnvironment('access_token', defaultValue: '');
   ```

3. **Pasar variables al compilar:**
   ```bash
   flutter run --dart-define-from-file=env.json
   ```

**La clase `AppConfig` centraliza todas las configuraciones:**
- `baseUrl`: URL base de la API (obligatorio)
- `accessToken`: Token de autenticación (obligatorio)
- `httpTimeout`: Timeout para peticiones HTTP (hardcodeado: 10 segundos)
- `defaultLanguage`: Idioma por defecto (hardcodeado: 'es-ES')

**Ubicación:** `lib/core/config/app_config.dart`

**Importante:** Si no se proporcionan `base_url` y `access_token`, la aplicación no podrá hacer peticiones a la API.

## Configuración de Firebase

El proyecto utiliza **Firebase** para Remote Config y Analytics.

### Configuración Inicial

1. **Crear proyecto en Firebase Console**
   - Ve a [Firebase Console](https://console.firebase.google.com/)
   - Crea un nuevo proyecto o selecciona uno existente

2. **Agregar apps Android e iOS**
   - En Firebase Console, ve a "Agregar app"
   - Selecciona Android y completa el formulario:
     - **Package name**: `com.lucadev.imdumb` (verifica en `android/app/build.gradle.kts`)
     - Descarga `google-services.json`
   - Repite para iOS:
     - **Bundle ID**: `com.lucadev.imdumb` (verifica en `ios/Runner.xcodeproj`)
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

### Cache con SQLite

El proyecto implementa un sistema de caché usando **SQLite** a través de `sqflite`, siguiendo principios SOLID:

- **Interfaz abstracta**: `CacheDatabaseService` (DIP, OCP)
- **Implementación SQLite**: `SqfliteCacheDatabaseService`
- **Implementación Drift** (alternativa): `DriftCacheDatabaseService`

Esta arquitectura permite cambiar entre diferentes implementaciones de base de datos (SQLite, Drift) sin modificar el código cliente, siguiendo los principios de Inversión de Dependencias y Abierto/Cerrado.

El caché almacena:
- Películas populares
- Películas en cartelera
- Películas mejor calificadas
- Géneros
- Películas por género

## Endpoints Utilizados

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
- `GET /search/movie?query={query}&include_adult=false&language={language}&page={page}` - Búsqueda de películas
- `GET /movie/{movieId}` - Detalle de película
- `GET /movie/{movieId}/images` - Imágenes de película
- `GET /movie/{movieId}/credits` - Créditos (cast) de película
- `GET /credit/{creditId}` - Detalle de crédito

### Autenticación

La API requiere un token de acceso (Bearer Token) que debe configurarse en las variables de entorno.

**Token incluido para la prueba técnica:**
- El token de acceso está incluido en el archivo `env.json` del repositorio
- Este token es válido durante la duración de la prueba técnica
- Una vez finalizada la prueba, el token será invalidado

**Para obtener tu propio token de TMDB (producción):**
1. Crea una cuenta en [TMDB](https://www.themoviedb.org/)
2. Ve a tu perfil → Configuración → API
3. Genera un API Key (Read Access Token)
4. Usa el token como `access_token` en la configuración

**Nota de seguridad:** En producción, nunca incluyas tokens en el repositorio. Usa variables de entorno seguras o servicios de gestión de secretos.

## Principios SOLID Documentados

El código incluye documentación explícita de principios SOLID en múltiples ubicaciones. Cada principio está documentado con comentarios explicativos en el código fuente.

### Ubicaciones de Documentación SOLID

#### 1. Single Responsibility Principle (SRP)

**Ubicaciones principales:**

- **`lib/features/home/domain/use_cases/fetch_all_popular_movie_usecase.dart`** (línea 7)
  - Comentario: "Este UseCase tiene una única responsabilidad: obtener películas populares"
  - Ejemplo: Cada UseCase encapsula una única acción de negocio

- **`lib/features/home/presentation/bloc/orchestrator/home_orchestrator_bloc.dart`** (línea 14)
  - Comentario: "Este bloc tiene una única responsabilidad: orquestar la carga de datos"
  - Ejemplo: Coordina múltiples BLoCs manteniendo una única responsabilidad

- **`lib/core/database/app_database.dart`** (línea 14)
  - Comentario: "Esta base de datos tiene una única responsabilidad: gestionar el almacenamiento local"
  - Ejemplo: Gestiona solo el acceso a la base de datos

- **`lib/core/services/firebase/firebase_analytics_service_impl.dart`** (línea 5)
  - Comentario: "Esta clase tiene una única responsabilidad: implementar AnalyticsService"
  - Ejemplo: Solo maneja eventos de analytics

- **`lib/features/home/data/datasource/local/home_local_datasource.dart`** (línea 5)
  - Comentario: "Este datasource tiene una única responsabilidad: gestionar el almacenamiento y recuperación de datos locales"
  - Ejemplo: Solo maneja operaciones de caché local

#### 2. Open/Closed Principle (OCP)

**Ubicaciones principales:**

- **`lib/core/services/network/dio_services_impl.dart`** (línea 4)
  - Comentario: "Esta clase está abierta para extensión pero cerrada para modificación"
  - Ejemplo: Puedes crear otra implementación de `ApiServices` sin modificar esta clase

- **`lib/core/database/cache_database_service.dart`** (línea 4)
  - Comentario: "Permite cambiar la implementación de base de datos sin afectar el código cliente"
  - Ejemplo: Interfaz que permite agregar nuevas implementaciones (SQLite, Drift) sin modificar código existente

- **`lib/core/database/sqflite_cache_database_service.dart`** (línea 11)
  - Comentario: "Esta implementación está abierta para extensión pero cerrada para modificación"
  - Ejemplo: Estrategia alternativa de almacenamiento usando SQLite

- **`lib/core/database/drift_cache_database_service.dart`** (línea 10)
  - Comentario: "Permite mantener compatibilidad mientras se puede cambiar fácilmente a otra implementación"
  - Ejemplo: Wrapper de Drift que implementa la misma interfaz

- **`lib/core/services/local/shared_preferences_service_impl.dart`** (línea 10)
  - Comentario: "Esta arquitectura permite cambiar fácilmente a otras implementaciones sin modificar el código cliente"
  - Ejemplo: Puede ser reemplazado por flutter_secure_storage, Hive, etc.

#### 3. Dependency Inversion Principle (DIP)

**Ubicaciones principales:**

- **`lib/core/services/network/api_services.dart`** (línea 1)
  - Comentario: "Las clases de alto nivel dependen de esta abstracción, no de implementaciones concretas"
  - Ejemplo: Interfaz abstracta que permite cambiar implementaciones HTTP

- **`lib/core/database/cache_database_service.dart`** (línea 4)
  - Comentario: "Las clases de alto nivel dependen de esta abstracción, no de implementaciones concretas"
  - Ejemplo: Interfaz que permite cambiar entre SQLite y Drift

- **`lib/core/services/local/local_storage_service.dart`** (línea 1)
  - Comentario: "Dependencias apuntan a abstracciones, no de implementaciones concretas"
  - Ejemplo: Interfaz que permite cambiar entre SharedPreferences, Hive, etc.

- **`lib/core/services/firebase/remote_config_service.dart`** (línea 1)
  - Comentario: "Dependencias apuntan a abstracciones"
  - Ejemplo: Interfaz abstracta para Remote Config

- **`lib/features/home/presentation/home_screen.dart`** (línea 92)
  - Comentario: "El screen depende de la abstracción AnalyticsService, no de la implementación concreta"
  - Ejemplo: Uso de inyección de dependencias con abstracciones

- **`lib/features/movie_detail/presentation/movie_detail_screen.dart`** (línea 94)
  - Comentario: "El screen depende de la abstracción AnalyticsService, no de la implementación concreta"
  - Ejemplo: Dependencia de abstracción en lugar de implementación concreta

### Cómo Buscar la Documentación SOLID

Para encontrar todos los comentarios SOLID en el código, busca por:
- `SOLID:` en comentarios
- `Single Responsibility Principle`
- `Open/Closed Principle`
- `Dependency Inversion Principle`

**Ejemplo de búsqueda:**
```bash
# Buscar todos los comentarios SOLID
grep -r "SOLID:" lib/
```

### Resumen de Principios Documentados

- **SRP (Single Responsibility)**: 15+ ubicaciones documentadas
- **OCP (Open/Closed)**: 5+ ubicaciones documentadas
- **DIP (Dependency Inversion)**: 10+ ubicaciones documentadas

Todos los principios están documentados con comentarios explicativos que describen cómo se aplican en cada caso específico.

## Características Principales

### Pantalla Principal (Home)
- Carrusel de películas populares sincronizado con imagen de fondo
- Secciones: Now Playing, Top Rated, Películas por Género
- Drawer con navegación por géneros
- Scroll infinito en listas horizontales
- Imagen de fondo animada basada en película popular del carrusel

### Pantalla de Detalle
- Carrusel de imágenes en el AppBar (SliverAppBar)
- Título, calificación, duración, géneros
- Descripción en HTML renderizada con flutter_html
- Lista horizontal de actores (cast)
- Botón fijo inferior "Recomendar"

### Modal de Recomendación
- Muestra detalles de la película (descripción HTML)
- Modal que crece en altura según contenido (isScrollControlled)
- Campo de texto para comentarios
- Botón para confirmar
- Mensaje de éxito (SnackBar) al confirmar

### Lista de Películas
- Vista en grid
- Filtrado por categoría o género
- Scroll infinito
- Navegación al detalle

### Búsqueda de Películas
- Búsqueda en tiempo real con debouncer (500ms)
- Grid de resultados con scroll infinito
- Campo de búsqueda integrado en el AppBar
- Acceso desde el icono de búsqueda en Home
- Paginación automática al hacer scroll

## Tests

El proyecto incluye una suite completa de tests:

### Tests Unitarios (33 archivos, ~54 casos de prueba)

- **Domain Layer**: Todos los UseCases tienen tests unitarios
- **Presentation Layer (BLoC)**: Todos los BLoCs principales tienen tests
- **Presentation Layer (Widgets)**: Pantallas principales y componentes testeados
- **Core Widgets**: Componentes reutilizables testeados

### Tests de Integración (5 archivos, ~8 casos de prueba)

- Flujo Splash → Home
- Pantalla principal con todas las secciones
- Pantalla de detalle
- Lista de películas
- Búsqueda de películas

### Herramientas de Testing

- `flutter_test` - Framework de testing de Flutter
- `bloc_test` - Testing de BLoCs
- `mockito` / `mocktail` - Mocking de dependencias
- `integration_test` - Tests de integración

## Checklist de Requisitos del Reto Técnico

### Entrega Mínima (Requerimientos Obligatorios)

- [x] App desarrollada en Flutter (Dart)
- [x] No se usa frameworks todo-en-uno (GetX, etc.)
- [x] UI construida exclusivamente con Widgets Flutter
- [x] Configuración de environments (Schema/Targets con dart-define)
- [x] Clean Architecture con separación clara de capas (Presentation, Domain, Data)
- [x] Manejo de estado con BLoC
- [x] Splash screen que lee datos desde Firebase Remote Config y guarda en almacenamiento local
- [x] Pantalla principal con listado de categorías de películas
- [x] Listas anidadas (categorías con películas dentro)
- [x] Schema/Targets para configuraciones
- [x] Pantalla de detalle con:
  - [x] Carrusel de imágenes
  - [x] Título, calificación, resumen/descripción en HTML
  - [x] Lista de actores (horizontal)
  - [x] Botón fijo inferior "Recomendar"
- [x] Modal de Recomendar con:
  - [x] Texto del detalle de la película
  - [x] Modal que crece en altura según contenido
  - [x] Caja de texto para comentario
  - [x] Botón para confirmar
  - [x] Mensaje de éxito al confirmar
- [x] Documentación de al menos 3 principios SOLID en código
- [x] README.md completo con toda la información requerida

### Requerimientos Técnicos

- [x] Dio para networking (obligatorio)
- [x] Firebase FlutterFire (Analytics + Remote Config)
- [x] BLoC para manejo de estado
- [x] SharedPreferences para flags simples
- [x] Cache con SQLite (sqflite)

### README.md - Contenido Requerido

- [x] Resumen del proyecto
- [x] Arquitectura usada (explicación textual con diagrama)
- [x] Tech stack y dependencias (con versiones)
- [x] Cómo correr el proyecto:
  - [x] Versión de Flutter (3.38.5)
  - [x] Pasos: git clone, flutter pub get, flutter run
  - [x] Configuración de Firebase
  - [x] Endpoints utilizados
- [x] Dónde se documentan los principios SOLID en el código (sección detallada con ubicaciones)
- [ ] Capturas de pantalla o GIFs (opcional, no incluido)

## Estado del Proyecto

### Implementado

- Clean Architecture completa con separación clara de capas
- BLoC Pattern para state management
- Consumo de API REST con Dio
- Integración con Firebase (Core, Remote Config, Analytics)
- Pantallas principales funcionales
- Navegación con auto_route
- HTML rendering para descripciones
- Schema/Targets para configuraciones
- Documentación SOLID en código (15+ ubicaciones)
- Cache con SQLite (intercambiable con Drift)
- SharedPreferences para almacenamiento local
- Tests unitarios completos (33 archivos, ~54 casos)
- Tests de integración (5 archivos, ~8 casos)

## Notas Importantes para Nuevos Desarrolladores

### Antes de Ejecutar la Aplicación

1. **DEBES crear el archivo `env.json`** con tu token de TMDB (ver sección "Configurar variables de entorno")
2. **DEBES configurar Firebase** si quieres usar Remote Config y Analytics (ver sección "Configuración de Firebase")
3. **DEBES ejecutar `build_runner`** si es la primera vez que clonas el proyecto para generar código de auto_route y mocks

### Orden Recomendado de Pasos

1. Clonar repositorio
2. Instalar dependencias (`flutter pub get`)
3. Crear archivo `env.json` con tus credenciales
4. Generar código (`flutter pub run build_runner build --delete-conflicting-outputs`)
5. Configurar Firebase (si aplica)
6. Ejecutar aplicación (`flutter run --dart-define-from-file=env.json`)

## Licencia

Este proyecto es una prueba técnica y está destinado únicamente para evaluación.

## Autor

**Luis Carranza** (@lucadevv)

Desarrollado como parte de una prueba técnica para el puesto de Desarrollador Flutter Senior.

