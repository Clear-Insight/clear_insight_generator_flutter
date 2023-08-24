import 'package:clear_insight_generator/event.dart';

class EventModel {
  final String id;
  final List<EventParameterModel> parameters;
  final String name;

  EventModel({
    required this.id,
    required this.parameters,
    required this.name,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      parameters: (json['parameters'] as Map<String, dynamic>)
          .entries
          .map((MapEntry<String, dynamic> entry) =>
              EventParameterModel.fromJson(entry.key, entry.value as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
    );
  }
}
