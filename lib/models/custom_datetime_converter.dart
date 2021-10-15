import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime? json) {
    if (json == null) return "";

    return json.toIso8601String().substring(0, 23);
  }
}
