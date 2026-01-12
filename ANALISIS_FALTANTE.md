# Análisis de Requisitos Faltantes - IMDUMB

## ✅ REQUISITOS COMPLETADOS

### Entrega Mínima
1. ✅ App desarrollada en Flutter (Dart)
2. ✅ No frameworks todo-en-uno (BLoC)
3. ✅ UI con Widgets Flutter exclusivamente
4. ✅ Configuración de environments (AppConfig con String.fromEnvironment)
5. ✅ Clean Architecture (presentation/domain/data)
6. ✅ Manejo de estado BLoC
7. ✅ Pantalla principal con categorías de películas
8. ✅ Listas anidadas (una lista dentro de otra)
9. ✅ Scheme/Targets (AppConfig)
10. ✅ Pantalla de Detalle con:
    - ✅ Carrusel de imágenes
    - ✅ Título, calificación, descripción en HTML
    - ✅ Lista de actores (horizontal)
    - ✅ Botón "Recomendar" fijo inferior
11. ✅ Modal de Recomendar con:
    - ✅ Texto del detalle (crece en altura)
    - ✅ Caja de texto para comentario
    - ✅ Botón confirmar
    - ✅ Mensaje de éxito (SnackBar)
12. ✅ Documentación SOLID en código (comentarios en 3+ lugares)
13. ✅ README.md con:
    - ✅ Resumen del proyecto
    - ✅ Arquitectura
    - ✅ Tech stack y dependencias
    - ✅ Instrucciones de instalación/ejecución
    - ✅ Configuración de environments
    - ✅ API endpoints
    - ✅ Documentación SOLID

### Requerimientos Técnicos
1. ✅ Dio para networking
2. ✅ BLoC para manejo de estado
3. ✅ Organización del proyecto clara

---

## ❌ REQUISITOS FALTANTES (CRÍTICOS)

### 1. Firebase Integration (OBLIGATORIO)
**Estado**: ❌ NO IMPLEMENTADO

**Requisito**:
- Firebase FlutterFire (Analytics + Remote Config o Realtime Database)
- Splash screen debe leer datos desde Firebase y guardarlos en almacenamiento local

**Acciones requeridas**:
1. Agregar dependencias de Firebase:
   ```yaml
   firebase_core: ^X.X.X
   firebase_analytics: ^X.X.X
   firebase_remote_config: ^X.X.X  # O firebase_database
   ```
2. Configurar Firebase:
   - Crear proyecto en Firebase Console
   - Agregar `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
   - Inicializar Firebase en `main.dart`
3. Implementar lectura de datos en Splash Screen:
   - Leer configuración desde Remote Config o Realtime Database
   - Guardar en SharedPreferences
   - Navegar a HomeScreen después de cargar

**Archivos a crear/modificar**:
- `lib/core/services/firebase/remote_config_service.dart` (o `database_service.dart`)
- `lib/core/services/local/shared_preferences_service.dart`
- `lib/features/splash/presentation/splash_screen.dart` (modificar)
- `lib/main.dart` (agregar inicialización de Firebase)

---

### 2. Splash Screen con Firebase (OBLIGATORIO)
**Estado**: ⚠️ EXISTE PERO NO IMPLEMENTA FIREBASE

**Requisito**:
- Al iniciarse, leer datos desde Firebase
- Guardar en almacenamiento local (SharedPreferences)
- Cargar configuración (ambiente, feature toggles, o texto inicial)

**Acciones requeridas**:
1. Modificar `splash_screen.dart` para:
   - Leer datos de Firebase Remote Config o Realtime Database
   - Guardar en SharedPreferences
   - Mostrar loading mientras se carga
   - Navegar a HomeScreen después

**Ejemplo de datos a guardar**:
- Configuración de ambiente
- Feature toggles
- Texto inicial/configuración
- URLs base (opcional, ya se usa String.fromEnvironment)

---

### 3. Almacenamiento Local (OBLIGATORIO)
**Estado**: ❌ NO IMPLEMENTADO

**Requisito**:
- SharedPreferences para flags simples

**Acciones requeridas**:
1. Agregar dependencia:
   ```yaml
   shared_preferences: ^X.X.X
   ```
2. Crear servicio de almacenamiento local:
   - `lib/core/services/local/shared_preferences_service.dart`
   - Interfaz abstracta + implementación
3. Integrar con Splash Screen para guardar datos de Firebase

**Cache opcional** (sugerido pero no obligatorio):
- Hive o SQFlite para cache de datos
- Por ahora NO es crítico, pero podría mejorarse

---

### 4. Firebase en README (OBLIGATORIO)
**Estado**: ⚠️ README existe pero NO menciona Firebase

**Acciones requeridas**:
1. Agregar sección "Configuración de Firebase" en README.md
2. Incluir:
   - Pasos para crear proyecto Firebase
   - Cómo obtener `google-services.json` y `GoogleService-Info.plist`
   - Dónde colocar los archivos
   - Inicialización en el código

---

## 📋 RESUMEN DE TAREAS PENDIENTES

### Prioridad CRÍTICA (Obligatorio)
1. **Firebase Setup**
   - [ ] Agregar dependencias Firebase a `pubspec.yaml`
   - [ ] Configurar Firebase en proyecto
   - [ ] Inicializar Firebase en `main.dart`

2. **Splash Screen con Firebase**
   - [ ] Crear servicio Firebase (Remote Config o Realtime Database)
   - [ ] Crear servicio SharedPreferences
   - [ ] Modificar `splash_screen.dart` para leer de Firebase
   - [ ] Guardar datos en SharedPreferences
   - [ ] Navegar a HomeScreen después de cargar

3. **Documentación Firebase en README**
   - [ ] Agregar sección de configuración Firebase
   - [ ] Incluir pasos de instalación

### Prioridad MEDIA (Sugerido pero no crítico)
4. **Cache con Hive/SQFlite** (opcional)
   - Por ahora NO es necesario si no hay cache implementado
   - Puede dejarse para futuras mejoras

---

## 🎯 PLAN DE IMPLEMENTACIÓN RECOMENDADO

### Fase 1: Setup Firebase
1. Crear proyecto en Firebase Console
2. Agregar apps Android e iOS
3. Descargar archivos de configuración
4. Agregar dependencias a `pubspec.yaml`

### Fase 2: Servicios
1. Crear `SharedPreferencesService` (interfaz + implementación)
2. Crear `FirebaseRemoteConfigService` o `FirebaseDatabaseService`
3. Registrar en DI

### Fase 3: Splash Screen
1. Modificar `splash_screen.dart` para usar Firebase
2. Leer datos de Firebase
3. Guardar en SharedPreferences
4. Navegar a HomeScreen

### Fase 4: Documentación
1. Actualizar README.md con Firebase
2. Incluir capturas si es posible

---

## 📊 IMPACTO

### Requisitos Faltantes:
- **1 crítico**: Firebase + Splash Screen (OBLIGATORIO)
- **1 importante**: SharedPreferences (OBLIGATORIO)
- **1 documentación**: README Firebase (OBLIGATORIO)

### Total de Requisitos:
- ✅ Completados: ~90%
- ❌ Faltantes: ~10% (pero son críticos)

### Tiempo estimado:
- Firebase setup: 30-45 min
- Implementación servicios: 30-45 min
- Splash Screen: 30 min
- Documentación: 15 min
- **Total**: ~2 horas

---

## ✅ CHECKLIST FINAL

- [ ] Firebase agregado a `pubspec.yaml`
- [ ] Firebase configurado (archivos .json/.plist)
- [ ] Firebase inicializado en `main.dart`
- [ ] SharedPreferences agregado a `pubspec.yaml`
- [ ] `SharedPreferencesService` creado
- [ ] `FirebaseRemoteConfigService` o `FirebaseDatabaseService` creado
- [ ] `splash_screen.dart` modificado para usar Firebase
- [ ] Datos de Firebase guardados en SharedPreferences
- [ ] README.md actualizado con Firebase
- [ ] Proyecto probado y funcionando
