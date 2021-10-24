// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qiyu_user_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QiyuUserInfoData _$QiyuUserInfoDataFromJson(Map<String, dynamic> json) =>
    QiyuUserInfoData(
      index: json['index'] as int?,
      key: json['key'] as String,
      value: json['value'] as String,
      label: json['label'] as String,
      href: json['href'] as String?,
      hidden: json['hidden'] as bool,
    );

Map<String, dynamic> _$QiyuUserInfoDataToJson(QiyuUserInfoData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('index', instance.index);
  val['key'] = instance.key;
  val['value'] = instance.value;
  val['label'] = instance.label;
  writeNotNull('href', instance.href);
  writeNotNull('hidden', instance.hidden);
  return val;
}
