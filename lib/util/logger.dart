import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogMe {
  static final Logger _logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)

  );

  static logInfo(String msg) => {if (kDebugMode) _logger.i(msg)};

  static logError(String msg) => _logger.e(msg);

  static logVerbose(String msg) => _logger.v(msg);
}
