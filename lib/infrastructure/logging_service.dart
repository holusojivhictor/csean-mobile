import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/services/logging_service.dart';
import 'package:logger/logger.dart';
import 'package:sprintf/sprintf.dart';

class LoggingServiceImpl implements LoggingService {
  final _logger = Logger();

  LoggingServiceImpl();

  @override
  void info(Type type, String msg, [List<Object>? args]) {
    assert(!msg.isNullEmptyOrWhitespace);

    if (args != null && args.isNotEmpty) {
      _logger.i('$type - ${sprintf(msg, args)}');
    } else {
      _logger.i('$type - $msg');
    }
  }

  @override
  void warning(Type type, String msg, [dynamic ex, StackTrace? trace]) {
    assert(!msg.isNullEmptyOrWhitespace);
    final tag = type.toString();
    _logger.w('$tag - ${_formatEx(msg, ex)}', ex, trace);
  }

  @override
  void error(Type type, String msg, [dynamic ex, StackTrace? trace]) {
    assert(!msg.isNullEmptyOrWhitespace);
    final tag = type.toString();
    _logger.e('$tag - ${_formatEx(msg, ex)}', ex, trace);
  }

  String _formatEx(String msg, dynamic ex) {
    if (ex != null) {
      return '$msg \n $ex';
    }
    return '$msg \n No exception available';
  }
}