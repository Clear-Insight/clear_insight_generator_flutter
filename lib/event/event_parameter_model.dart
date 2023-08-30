class EventParameterModel {
  final String type;
  final bool required;
  final String id;
  final String name;

  EventParameterModel({
    required this.type,
    required this.required,
    required this.id,
    required this.name,
  });

  factory EventParameterModel.fromJson(String id, Map<String, dynamic> json) {
    return EventParameterModel(
      id: id,
      name: json['name'] as String,
      type: json['type'] as String,
      required: json['required'] as bool,
    );
  }
}
