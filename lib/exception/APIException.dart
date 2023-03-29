

import '../models/error_api.dart';

class APIException implements Exception {
  final ErrorApi errorApi;

  APIException(this.errorApi);

  @override
  String toString() {
    return '${errorApi.msg}';
  }
}
