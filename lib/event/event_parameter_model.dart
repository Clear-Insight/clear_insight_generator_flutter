class EventParameterModel {
  final String type;
  final bool required;
  final String name;

  EventParameterModel({
    required this.type,
    required this.required,
    required this.name,
  });

  factory EventParameterModel.fromJson(String name, Map<String, dynamic> json) {
    return EventParameterModel(
      name: name,
      type: json['type'] as String,
      required: json['required'] as bool,
    );
  }
}
