// ignore_for_file: file_names

class UrlModel {
  UrlModel();
  late String title;
  late String url;
  late int duration;
  bool status = false;
  factory UrlModel.fromJson(Map<String, dynamic> json) =>
      _$UrlModelFromJson(json);
  Map<String, dynamic> toJson() => _$UrlModelToJson(this);
}

UrlModel _$UrlModelFromJson(Map<String, dynamic> json) => UrlModel()
  ..title = json['title'] as String
  ..url = json['url'] as String
  ..duration = json['duration'] as int
  ..status = json['status'] as bool;

Map<String, dynamic> _$UrlModelToJson(UrlModel instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'duration': instance.duration,
      'status': instance.status,
    };
