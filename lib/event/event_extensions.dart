import 'package:clear_insight_generator/event.dart';
import 'package:clear_insight_generator/extensions/string_extensions.dart';

extension EventExtensions on EventModel {
  String get toFunctionName {
    final camelCase = name.toCamelCase;
    return 'log${camelCase[0].toUpperCase()}${camelCase.substring(1)}';
  }
}
