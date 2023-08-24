import 'package:clear_insight_generator/event.dart';

class EventsModel {
  final String projectId;
  final List<EventModel> events;

  EventsModel({
    required this.projectId,
    required this.events,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      projectId: json['project_id'] as String,
      events: (json['events'] as List<dynamic>)
          .map((dynamic eventJson) => EventModel.fromJson(eventJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
