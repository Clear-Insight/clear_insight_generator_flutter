import 'dart:convert';
import 'dart:core';

import 'package:build/build.dart';
import 'package:http/http.dart';
import 'package:clear_insight_generator/core.dart';
import 'package:clear_insight_generator/event.dart';
import 'package:clear_insight_generator/extensions.dart';
import 'package:source_gen/source_gen.dart';

class ClearInsightGenerator extends Generator {
  ClearInsightGenerator({required BuilderOptions options}) : _options = options;

  final BuilderOptions _options;

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final projectId = _options.config['project_id'] as String;
    final httpClient = Client();
    final client = ClearInsightHttpClient(
      inner: httpClient,
      projectId: projectId,
    );
    final eventsResponse = await client.get(
      Uri.parse(
        'https://gist.githubusercontent.com/Joran-Dob/ee06567aa06cad977d21acd4a4e055b2/raw/f4392d8934deafdabfb9e7fa96c21561bbd75fba/events.json',
      ),
    );
    final eventsJson = jsonDecode(eventsResponse.body) as Map<String, dynamic>;
    final eventsResponseItem = EventsModel.fromJson(eventsJson);

    final buffer = StringBuffer()
      ..writeAll(
        [
          _fileHeader(sourceUri: library.element.source.uri.toString()),
          ..._events(events: eventsResponseItem.events),
          _fileFooter,
        ],
      );
    return buffer.toString();
  }
}

List<String> _events({
  required List<EventModel> events,
}) =>
    events.map(_toEventFunction).toList();

String _toEventFunction(EventModel event) {
  final functionParameters = event.parameters
      .map((parameter) =>
          '${parameter.required ? 'required' : ''} ${parameter.type} ${parameter.name.toCamelCase}')
      .join(', ');
  final parameters = event.parameters
      .map((parameter) => "'${parameter.name}': ${parameter.name.toCamelCase}")
      .join(', ');
  return '''
    void ${event.toFunctionName}({$functionParameters,}) => logEvent(
      (
        id: '${event.id}',
        parameters: {
          $parameters,
        },
        name: '${event.name}',
      ),
    );
    
  ''';
}

String _fileHeader({required String sourceUri}) {
  return '''
  import 'package:clear_insight/clear_insight.dart';

  extension ClearInsightEventExtension on ClearInsight {
  ''';
}

String get _fileFooter {
  return '''
  }
  ''';
}

Builder clearInsightBuilder(BuilderOptions options) => LibraryBuilder(
      ClearInsightGenerator(options: options),
      generatedExtension: '.clear.dart',
    );
