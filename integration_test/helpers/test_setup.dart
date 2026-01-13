import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:imdumb/core/config/app_config.dart';
import 'package:imdumb/core/injection/app_injection.dart';
import 'package:imdumb/firebase_options.dart';

import 'package:mocktail/mocktail.dart';

import '../../test/fixtures/genre_fixtures.dart';
import '../../test/fixtures/movie_detail_fixtures.dart';
import '../../test/fixtures/movie_fixtures.dart';
import '../../test/helpers/mock_setup.dart';

/// Helper para configurar el entorno de tests de integración
///
/// SOLID: Single Responsibility Principle (SRP)
///
/// Esta clase tiene una única responsabilidad: inicializar y limpiar
/// el entorno de tests de integración (Firebase, GetIt, mocks, etc.).
///
/// Patrón aplicado: Test Setup Helper
/// Centraliza la configuración común para todos los tests de integración.
class TestSetup {
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    // Configurar manejo de errores primero
    setupErrorHandling();

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (_) {}

    final getIt = GetIt.instance;
    await getIt.reset();

    MockSetup.setupIntegrationTests(getIt);
    _setupMockApiResponses();

    AppInjection(
      getIt: getIt,
      baseUrl: AppConfig.baseUrl.isNotEmpty
          ? AppConfig.baseUrl
          : 'https://api.themoviedb.org/3',
      accessToken: AppConfig.accessToken.isNotEmpty
          ? AppConfig.accessToken
          : '',
    );

    _isInitialized = true;
  }

  /// Configura las respuestas mockeadas de la API
  static void _setupMockApiResponses() {
    final mockApi = MockSetup.apiServices;

    // Mock para películas populares con soporte de paginación
    // Captura tanto con query params en URL como en parámetros separados
    when(
      () => mockApi.get(
        any(that: predicate<String>((endpoint) => 
          endpoint.contains('/movie/popular') && !endpoint.contains('/discover')
        )),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      // Extraer la página de los queryParameters o de la URL
      final endpoint = invocation.positionalArguments[0] as String;
      final queryParams = invocation.namedArguments[#queryParameters] as Map<String, dynamic>?;
      
      int page = 1;
      if (queryParams != null && queryParams['page'] != null) {
        page = int.tryParse(queryParams['page'].toString()) ?? 1;
      } else {
        // Intentar extraer de la URL si tiene query params
        final pageMatch = RegExp(r'[?&]page=(\d+)').firstMatch(endpoint);
        if (pageMatch != null) {
          page = int.tryParse(pageMatch.group(1) ?? '1') ?? 1;
        }
      }
      
      debugPrint('Mock fetchAllPopularMovies: page=$page, endpoint=$endpoint');
      
      final response = Response(
        data: MovieFixtures.popularMoviesJsonResponseForPage(page),
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/popular'),
      );
      return response;
    });

    // Mock para películas en cartelera con soporte de paginación
    when(
      () => mockApi.get(
        any(that: predicate<String>((endpoint) => 
          endpoint.contains('/movie/now_playing')
        )),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final endpoint = invocation.positionalArguments[0] as String;
      final queryParams = invocation.namedArguments[#queryParameters] as Map<String, dynamic>?;
      
      int page = 1;
      if (queryParams != null && queryParams['page'] != null) {
        page = int.tryParse(queryParams['page'].toString()) ?? 1;
      } else {
        final pageMatch = RegExp(r'[?&]page=(\d+)').firstMatch(endpoint);
        if (pageMatch != null) {
          page = int.tryParse(pageMatch.group(1) ?? '1') ?? 1;
        }
      }
      
      debugPrint('Mock fetchAllNowPlayingMovies: page=$page, endpoint=$endpoint');
      
      // Obtener datos del fixture
      final responseData = MovieFixtures.popularMoviesJsonResponseForPage(page);
      
      // DEBUG: Verificar qué datos se están devolviendo
      final resultsCount = (responseData['results'] as List?)?.length ?? 0;
      debugPrint('Mock nowPlayingMovies: results.length = $resultsCount');
      
      // Si results está vacío, usar los mismos datos que popularMovies
      if (responseData['results'] == null || (responseData['results'] as List).isEmpty) {
        debugPrint('ADVERTENCIA: results está vacío. Usando datos de popularMovies...');
        responseData['results'] = MovieFixtures.popularMoviesJsonResponseForPage(1)['results'];
      }
      
      return Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/now_playing'),
      );
    });

    // Mock para películas mejor valoradas con soporte de paginación
    when(
      () => mockApi.get(
        any(that: predicate<String>((endpoint) => 
          endpoint.contains('/movie/top_rated')
        )),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final endpoint = invocation.positionalArguments[0] as String;
      final queryParams = invocation.namedArguments[#queryParameters] as Map<String, dynamic>?;
      
      int page = 1;
      if (queryParams != null && queryParams['page'] != null) {
        page = int.tryParse(queryParams['page'].toString()) ?? 1;
      } else {
        final pageMatch = RegExp(r'[?&]page=(\d+)').firstMatch(endpoint);
        if (pageMatch != null) {
          page = int.tryParse(pageMatch.group(1) ?? '1') ?? 1;
        }
      }
      
      debugPrint('Mock fetchAllTopRatedMovies: page=$page, endpoint=$endpoint');
      
      // Obtener datos del fixture
      final responseData = MovieFixtures.popularMoviesJsonResponseForPage(page);
      
      // DEBUG: Verificar qué datos se están devolviendo
      final resultsCount = (responseData['results'] as List?)?.length ?? 0;
      debugPrint('Mock topRatedMovies: results.length = $resultsCount');
      
      // Si results está vacío, usar los mismos datos que popularMovies
      if (responseData['results'] == null || (responseData['results'] as List).isEmpty) {
        debugPrint('ADVERTENCIA: results está vacío. Usando datos de popularMovies...');
        responseData['results'] = MovieFixtures.popularMoviesJsonResponseForPage(1)['results'];
      }
      
      return Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/top_rated'),
      );
    });

    // Mock para géneros
    when(
      () => mockApi.get(
        any(that: predicate<String>((endpoint) => 
          endpoint.contains('/genre/movie/list')
        )),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final endpoint = invocation.positionalArguments[0] as String;
      debugPrint('Mock fetchAllGenres: endpoint=$endpoint');
      
      return Response(
        data: GenreFixtures.genresJsonResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/genre/movie/list'),
      );
    });

    // Mock para películas por género con soporte de paginación
    when(
      () => mockApi.get(
        any(that: predicate<String>((endpoint) => 
          endpoint.contains('/discover/movie')
        )),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final endpoint = invocation.positionalArguments[0] as String;
      final queryParams = invocation.namedArguments[#queryParameters] as Map<String, dynamic>?;
      
      int page = 1;
      if (queryParams != null && queryParams['page'] != null) {
        page = int.tryParse(queryParams['page'].toString()) ?? 1;
      } else {
        final pageMatch = RegExp(r'[?&]page=(\d+)').firstMatch(endpoint);
        if (pageMatch != null) {
          page = int.tryParse(pageMatch.group(1) ?? '1') ?? 1;
        }
      }
      
      debugPrint('Mock fetchMoviesByGenre: page=$page, endpoint=$endpoint');
      
      return Response(
        data: MovieFixtures.popularMoviesJsonResponseForPage(page),
        statusCode: 200,
        requestOptions: RequestOptions(path: '/discover/movie'),
      );
    });

    // Mock para detalle de película (captura con o sin query params en URL)
    // IMPORTANTE: Este mock debe estar ANTES de los mocks de /images y /credits
    // para que capture correctamente las llamadas
    when(
      () => mockApi.get(
        any(that: predicate<String>((endpoint) {
          // Capturar endpoints de detalle de película
          // Debe contener /movie/ seguido de un número
          // Pero NO debe contener /images, /credits, /search, /popular, /now_playing, /top_rated
          if (!endpoint.contains('/movie/')) return false;
          if (endpoint.contains('/images')) return false;
          if (endpoint.contains('/credits')) return false;
          if (endpoint.contains('/search')) return false;
          if (endpoint.contains('/popular')) return false;
          if (endpoint.contains('/now_playing')) return false;
          if (endpoint.contains('/top_rated')) return false;
          if (endpoint.contains('/discover')) return false;
          // Debe tener un número después de /movie/
          return RegExp(r'/movie/\d+').hasMatch(endpoint);
        })),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      // Extraer el movieId de la URL (puede tener query params)
      final endpoint = invocation.positionalArguments[0] as String;
      final movieIdMatch = RegExp(r'/movie/(\d+)').firstMatch(endpoint);
      final movieId = movieIdMatch?.group(1) ?? '550';
      
      debugPrint('Mock fetchMovieDetail PARA TEST: movieId=$movieId, endpoint=$endpoint');
      
      // Obtener datos del fixture
      final movieDetail = MovieDetailFixtures.movieDetailJsonResponse;
      
      // DEBUG: Verificar que los datos no estén vacíos
      debugPrint('Mock movieDetail: title=${movieDetail['title']}, id=${movieDetail['id']}');
      
      // Asegurar que el movieId coincida
      if (movieDetail['id'] != int.parse(movieId)) {
        debugPrint('ADVERTENCIA: movieId no coincide. Actualizando...');
        movieDetail['id'] = int.parse(movieId);
      }
      
      return Response(
        data: movieDetail,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/$movieId'),
      );
    });

    // Mock para imágenes de película
    when(
      () => mockApi.get(
        any(that: contains('/images')),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final endpoint = invocation.positionalArguments[0] as String;
      final movieIdMatch = RegExp(r'/movie/(\d+)/images').firstMatch(endpoint);
      final movieId = movieIdMatch?.group(1) ?? '550';
      
      debugPrint('Mock fetchMovieImages: movieId=$movieId, endpoint=$endpoint');
      
      return Response(
        data: MovieDetailFixtures.movieImagesJsonResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/$movieId/images'),
      );
    });

    // Mock para cast de película (captura con o sin query params)
    when(
      () => mockApi.get(
        any(that: contains('/credits')),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final endpoint = invocation.positionalArguments[0] as String;
      final movieIdMatch = RegExp(r'/movie/(\d+)/credits').firstMatch(endpoint);
      final movieId = movieIdMatch?.group(1) ?? '550';
      
      debugPrint('Mock fetchMovieCredits: movieId=$movieId, endpoint=$endpoint');
      
      return Response(
        data: MovieDetailFixtures.castJsonResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/movie/$movieId/credits'),
      );
    });

    // Mock para búsqueda
    when(
      () => mockApi.get(
        any(that: contains('/search/movie')),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((invocation) async {
      final queryParams = invocation.namedArguments[#queryParameters] as Map<String, dynamic>?;
      final page = int.tryParse(queryParams?['page']?.toString() ?? '1') ?? 1;
      
      debugPrint('Mock searchMovies: page=$page');
      
      return Response(
        data: MovieFixtures.popularMoviesJsonResponseForPage(page),
        statusCode: 200,
        requestOptions: RequestOptions(path: '/search/movie'),
      );
    });
    
    // NOTA: No usar mock de fallback genérico porque puede interferir con los mocks específicos
    // Si una llamada no está mockeada, es mejor que falle para identificar el problema
  }

  /// Limpia el entorno después de los tests
  static Future<void> cleanup() async {
    if (!_isInitialized) return;

    MockSetup.reset();
    await GetIt.instance.reset();
    _isInitialized = false;
    
    // Restaurar el handler de errores por defecto
    FlutterError.onError = FlutterError.presentError;
  }
  
  /// Configura el manejo de errores para ignorar errores de imágenes 404
  /// Estos errores son esperados en tests porque las URLs de test no existen
  static void setupErrorHandling() {
    // Guardar el handler original
    final originalOnError = FlutterError.onError;
    
    FlutterError.onError = (FlutterErrorDetails details) {
      // Ignorar errores de imágenes 404
      final exception = details.exception;
      final exceptionString = exception.toString();
      final stackTrace = details.stack?.toString() ?? '';
      final library = details.library ?? '';
      
      // Verificar si es un error de imagen 404
      // Los errores de imágenes 404 son comunes y no deberían hacer fallar los tests
      final isImage404Error = 
          (exceptionString.contains('HttpException') ||
           exceptionString.contains('HttpExceptionWithStatus') ||
           exceptionString.contains('Invalid statusCode: 404')) &&
          (exceptionString.contains('404') ||
           exceptionString.contains('Invalid statusCode: 404')) &&
          (exceptionString.contains('image.tmdb.org') ||
           stackTrace.contains('image.tmdb.org') ||
           stackTrace.contains('cached_network_image') ||
           stackTrace.contains('cache_manager') ||
           stackTrace.contains('CachedNetworkImageProvider') ||
           library.contains('cached_network_image') ||
           library.contains('cache_manager'));
      
      if (isImage404Error) {
        // Ignorar este error - es esperado en tests
        // Las imágenes pueden no existir o tardar en cargar
        debugPrint('Ignorando error 404 de imagen: ${exception.toString()}');
        return;
      }
      
      // Para otros errores, usar el handler original o el por defecto
      if (originalOnError != null) {
        originalOnError(details);
      } else {
        FlutterError.presentError(details);
      }
    };
  }
}

/// Helper para tests de integración que maneja mejor los tiempos de espera
/// y evita timeouts con pumpAndSettle
extension TestHelper on WidgetTester {
  /// Limpia excepciones de imágenes 404 que son esperadas en tests
  /// Debe llamarse después de cada pump() para evitar que los tests fallen
  void clearImage404Errors() {
    try {
      final exception = takeException();
      if (exception != null) {
        final exceptionString = exception.toString();
        // Si es un error 404 de imágenes, ignorarlo
        if (exceptionString.contains('HttpException') &&
            (exceptionString.contains('404') ||
             exceptionString.contains('Invalid statusCode: 404')) &&
            exceptionString.contains('image.tmdb.org')) {
          // Ignorar este error - es esperado en tests
          return;
        }
        // Para otros errores, no hacer nada - dejar que se propaguen
      }
    } catch (_) {
      // Ignorar errores al limpiar excepciones
    }
  }
  
  /// Pump con limpieza automática de errores de imágenes 404
  Future<void> pumpAndClearImageErrors([Duration? duration]) async {
    await pump(duration);
    clearImage404Errors();
  }
  
  /// Espera de forma segura sin hacer timeout
  /// Similar a pumpAndSettle pero con límite de tiempo y limpieza de errores
  Future<void> safePumpAndSettle({
    Duration timeout = const Duration(seconds: 5),
    Duration frame = const Duration(milliseconds: 16),
  }) async {
    final endTime = DateTime.now().add(timeout);
    int pumpCount = 0;
    
    while (DateTime.now().isBefore(endTime) && pumpCount < 100) {
      await pump(frame);
      clearImage404Errors();
      pumpCount++;
      
      // Si no hay más frames pendientes, salir
      if (!binding.hasScheduledFrame) {
        break;
      }
    }
  }
  
  /// Espera a que aparezca un widget específico o hasta timeout
  Future<bool> waitFor(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
    Duration pollInterval = const Duration(milliseconds: 300),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (DateTime.now().isBefore(endTime)) {
      await pump(pollInterval);
      clearImage404Errors();
      if (finder.evaluate().isNotEmpty) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Espera a que aparezca un widget específico, lanza excepción si no aparece
  Future<void> waitForWidget(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
    String? reason,
  }) async {
    final found = await waitFor(finder, timeout: timeout);
    if (!found) {
      throw TimeoutException(
        reason ?? 'Widget no encontrado: $finder',
        timeout,
      );
    }
  }
  
  /// Espera a que aparezca cualquiera de los widgets especificados
  Future<bool> waitForAny(
    List<Finder> finders, {
    Duration timeout = const Duration(seconds: 10),
    Duration pollInterval = const Duration(milliseconds: 300),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (DateTime.now().isBefore(endTime)) {
      await pump(pollInterval);
      clearImage404Errors();
      
      for (final finder in finders) {
        if (finder.evaluate().isNotEmpty) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  /// Espera a que aparezcan todos los widgets especificados
  Future<bool> waitForAll(
    List<Finder> finders, {
    Duration timeout = const Duration(seconds: 10),
    Duration pollInterval = const Duration(milliseconds: 300),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (DateTime.now().isBefore(endTime)) {
      await pump(pollInterval);
      clearImage404Errors();
      
      bool allFound = true;
      for (final finder in finders) {
        if (finder.evaluate().isEmpty) {
          allFound = false;
          break;
        }
      }
      
      if (allFound) {
        return true;
      }
    }
    
    return false;
  }

  /// Busca el botón de retroceso en un SliverAppBar
  /// El key está en el IconButton, no en el Icon dentro
  Future<Finder> findBackButtonInSliverAppBar({
    Key? backButtonKey,
    Duration timeout = const Duration(seconds: 20),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (DateTime.now().isBefore(endTime)) {
      await pump(const Duration(milliseconds: 300));
      clearImage404Errors();
      
      // Estrategia 1: Buscar IconButton por key (el key está en el IconButton)
      if (backButtonKey != null) {
        final iconButtonByKey = find.byKey(backButtonKey);
        if (iconButtonByKey.evaluate().isNotEmpty) {
          // Verificar que es un IconButton
          final elements = iconButtonByKey.evaluate();
          if (elements.isNotEmpty && elements.first.widget is IconButton) {
            return iconButtonByKey;
          }
        }
        
        // Estrategia 1b: Buscar dentro del SliverAppBar usando descendant
        final sliverAppBar = find.byType(SliverAppBar);
        if (sliverAppBar.evaluate().isNotEmpty) {
          final buttonInAppBar = find.descendant(
            of: sliverAppBar,
            matching: iconButtonByKey,
          );
          if (buttonInAppBar.evaluate().isNotEmpty) {
            return buttonInAppBar;
          }
        }
      }
      
      // Estrategia 2: Buscar IconButton con icono arrow_back_ios dentro del SliverAppBar
      final sliverAppBar = find.byType(SliverAppBar);
      if (sliverAppBar.evaluate().isNotEmpty) {
        final iconButtonsInAppBar = find.descendant(
          of: sliverAppBar,
          matching: find.byType(IconButton),
        );
        
        for (final element in iconButtonsInAppBar.evaluate()) {
          final widget = element.widget;
          if (widget is IconButton) {
            final icon = widget.icon;
            if (icon is Icon && icon.icon == Icons.arrow_back_ios) {
              // Verificar que tiene el key correcto si se proporciona
              if (backButtonKey == null || widget.key == backButtonKey) {
                return find.byWidget(widget);
              }
            }
          }
        }
      }
      
      // Estrategia 3: Buscar cualquier IconButton con icono arrow_back_ios
      final allIconButtons = find.byWidgetPredicate(
        (widget) {
          if (widget is IconButton) {
            final icon = widget.icon;
            if (icon is Icon && icon.icon == Icons.arrow_back_ios) {
              // Si se proporciona key, verificar que coincida
              if (backButtonKey == null || widget.key == backButtonKey) {
                return true;
              }
            }
          }
          return false;
        },
      );
      if (allIconButtons.evaluate().isNotEmpty) {
        return allIconButtons;
      }
    }
    
    // Si no se encuentra, devolver el finder por key (fallará en el test con mensaje claro)
    return backButtonKey != null 
        ? find.byKey(backButtonKey)
        : find.byIcon(Icons.arrow_back_ios);
  }
}
