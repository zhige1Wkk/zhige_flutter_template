import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HttpService {
  // 后端接口配置
  static String baseUrl = 'https://api.example.com'; // 替换为示例URL，避免使用localhost
  
  final Dio _dio;
  final Connectivity _connectivity;

  HttpService({Dio? dio, Connectivity? connectivity})
      : _dio = dio ?? Dio(),
        _connectivity = connectivity ?? Connectivity() {
    // 设置基础URL
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    
    // 添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 检查网络连接
          final connectivityResult = await _connectivity.checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: '没有网络连接',
                type: DioExceptionType.connectionError,
              ),
            );
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          // 错误处理，可以添加重试逻辑
          return handler.next(error);
        },
      ),
    );
  }

  // 静态方法用于更新baseUrl
  static void updateBaseUrl(String newBaseUrl) {
    baseUrl = newBaseUrl;
  }
  
  // 获取当前的baseUrl
  static String getBaseUrl() {
    return baseUrl;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    final requestOptions = options ?? Options();
    if (headers != null) {
      requestOptions.headers = headers;
    }
    
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final requestOptions = options ?? Options();
    if (headers != null) {
      requestOptions.headers = headers;
    }
    
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final requestOptions = options ?? Options();
    if (headers != null) {
      requestOptions.headers = headers;
    }
    
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    final requestOptions = options ?? Options();
    if (headers != null) {
      requestOptions.headers = headers;
    }
    
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
} 