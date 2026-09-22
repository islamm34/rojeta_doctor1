import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rojeta_doctor/core/network/endpoints.dart';

import '../../config/routes/app_router.dart';
import '../../main.dart';
import '../error/exceptions.dart';
import '../local/user_hive_helper.dart';
import '../utils/extensions/context_extensions.dart';
import '../utils/flutter_secure_storage_helper.dart';
import '../utils/snackbar_helper.dart';
import 'api_consumer.dart';

class DioClient implements ApiConsumer {
  final Dio dio;

  DioClient(this.dio) {
    dio.options
      ..baseUrl = Endpoints.baseUrl
      ..responseType = ResponseType.json
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {
        'accept': 'application/json',
        'content-type': 'application/json',
        'app-lang': UserHiveHelper.getUser()?.language ?? 'en',
      };

    // --- ADVANCED LOGGING & AUTH INTERCEPTOR ---
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await FlutterSecureStorageHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            log('🚀 [AUTH] Bearer $token');
          }

          log('🚀 [REQUEST] [${options.method}] URL: ${options.uri}');
          if (options.data != null) {
            if (options.data is Future<FormData> || options.data is FormData) {
              final formData = await options.data as FormData;
              final fields = formData.fields
                  .map((e) => '${e.key}: ${e.value}')
                  .toList();
              final files = formData.files
                  .map((e) => '${e.key}: ${e.value.filename}')
                  .toList();

              log('📦 [FORM DATA FIELDS]: $fields');
              log('📂 [FORM DATA FILES]: $files');
            } else {
              log('📦 [BODY]: ${options.data}');
            }
          }
          if (options.queryParameters.isNotEmpty) {
            log('❓ [QUERY PARAMS]: ${options.queryParameters}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.data != null) {
            response.data = _sanitizeResponseData(response.data);
          }
          log(
            '✅ [RESPONSE] [${response.statusCode}] FROM: ${response.requestOptions.path}',
          );
          log('📄 [DATA]: ${response.data}');

          // Show global success snackbar if a valid string 'message' is present
          final isSilent =
              response.requestOptions.extra['silent'] == true ||
              response.requestOptions.path.contains('device-token');

          if (!isSilent &&
              response.data is Map &&
              response.data['message'] != null) {
            final message = response.data['message'];
            if (message is String && message.isNotEmpty) {
              final context = RojetaDoctorApp.navigatorKey.currentContext;
              if (context != null && response.requestOptions.method != 'GET') {
                SnackbarHelper.showSuccess(context, message: message);
              }
            }
          }

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('❌ [ERROR] [${e.response?.statusCode ?? 'NO STATUS'}]');
          log('🔗 PATH: ${e.requestOptions.path}');
          log('⚠️ TYPE: ${e.type}');
          log('💬 MESSAGE: ${e.message}');
          if (e.response?.data != null) {
            log('📥 ERROR DATA: ${e.response?.data}');
          }

          final isSilent =
              e.requestOptions.extra['silent'] == true ||
              e.requestOptions.path.contains('device-token');

          if (isSilent) {
            return handler.next(e);
          }

          final context = RojetaDoctorApp.navigatorKey.currentContext;
          if (context != null) {
            final isChatMessagesGet404 =
                e.requestOptions.method == 'GET' &&
                e.requestOptions.path.contains('chat/messages') &&
                e.response?.statusCode == 404;

            final isDoctorStartChat405Or404 =
                e.requestOptions.path.contains('doctor/chat/conversations') &&
                e.requestOptions.method == 'POST' &&
                (e.response?.statusCode == 405 ||
                    e.response?.statusCode == 404);

            if (isChatMessagesGet404 || isDoctorStartChat405Or404) {
              return handler.next(e);
            }

            if (e.type == DioExceptionType.badResponse) {
              final statusCode = e.response?.statusCode;
              final errorMessage = _extractErrorMessage(
                e.response?.data,
                defaultMsg: 'Server error ($statusCode)',
              );
              SnackbarHelper.showError(context, message: errorMessage);
            } else if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.sendTimeout ||
                e.type == DioExceptionType.connectionError) {
              SnackbarHelper.showError(
                context,
                message: 'Network error, please check your connection.',
              );
            } else {
              final sanitized = _sanitizeErrorMessage(
                e.message,
                defaultMsg: 'An unknown error occurred.',
              );
              SnackbarHelper.showError(context, message: sanitized);
            }
          }

          if (e.response?.statusCode == 401) {
            log('🚫 [AUTH] 401 Unauthorized - Triggering session clear.');
            FlutterSecureStorageHelper.clearAll();
            UserHiveHelper.clearSession();

            final context = RojetaDoctorApp.navigatorKey.currentContext;
            if (context != null) {
              final String location = context.currentRouteName.toString();
              if (location != AppRoutes.login) {
                log('🚀 Redirecting to Login from $location');
                context.pushNamedAndRemoveUntil(AppRoutes.login);
              }
            }
          }

          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      throw NetworkException(
        message: 'Network error, please check your connection.',
      );
    }

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final message = _extractErrorMessage(e.response?.data);
      throw ServerException(message: message, statusCode: statusCode);
    }

    final message = _sanitizeErrorMessage(
      e.message,
      defaultMsg: 'An unknown error occurred.',
    );
    throw ServerException(message: message);
  }

  static String _extractErrorMessage(
    dynamic data, {
    String defaultMsg = 'Server error',
  }) {
    if (data == null) return defaultMsg;
    if (data is String && data.trim().isNotEmpty) {
      if (!data.trim().startsWith('<')) {
        return _sanitizeErrorMessage(data.trim(), defaultMsg: defaultMsg);
      }
      return defaultMsg;
    }
    if (data is Map) {
      final msg =
          data['message'] ?? data['error'] ?? data['msg'] ?? data['detail'];
      if (msg != null && msg.toString().trim().isNotEmpty) {
        return _sanitizeErrorMessage(
          msg.toString().trim(),
          defaultMsg: defaultMsg,
        );
      }
      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty) {
        final messages = errors.map((e) {
          if (e is Map && e['message'] != null) {
            return e['message'].toString();
          }
          return e.toString();
        }).toList();
        return messages.join('\n');
      }
      if (errors is Map && errors.isNotEmpty) {
        final messages = <String>[];
        for (final val in errors.values) {
          if (val is List) {
            messages.addAll(val.map((e) => e.toString()));
          } else if (val != null) {
            messages.add(val.toString());
          }
        }
        if (messages.isNotEmpty) {
          return messages.join('\n');
        }
      }
    }
    return defaultMsg;
  }

  static String _sanitizeErrorMessage(
    String? message, {
    String defaultMsg = 'An unknown server error occurred.',
  }) {
    if (message == null || message.trim().isEmpty) return defaultMsg;
    final clean = message.trim();
    final lower = clean.toLowerCase();
    if (lower.contains('serverexception') || lower.contains('instance of')) {
      return defaultMsg;
    }
    return clean;
  }

  static dynamic _sanitizeResponseData(dynamic data) {
    if (data is String) {
      if (data.contains('localhost') || data.contains('127.0.0.1')) {
        return data
            .replaceAll('http://localhost:8000', 'https://rojeta.fassla.net')
            .replaceAll('http://127.0.0.1:8000', 'https://rojeta.fassla.net')
            .replaceAll('http://localhost', 'https://rojeta.fassla.net')
            .replaceAll('https://localhost', 'https://rojeta.fassla.net')
            .replaceAll('http://127.0.0.1', 'https://rojeta.fassla.net');
      }
      return data;
    } else if (data is Map) {
      return Map<String, dynamic>.fromEntries(
        data.entries.map(
          (e) => MapEntry(e.key.toString(), _sanitizeResponseData(e.value)),
        ),
      );
    } else if (data is List) {
      return data.map(_sanitizeResponseData).toList();
    }
    return data;
  }
}
