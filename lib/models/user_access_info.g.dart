// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_access_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccessInfo _$UserAccessInfoFromJson(Map<String, dynamic> json) =>
    UserAccessInfo(
      token: json['token'] as String?,
      flags: json['flags'] as String?,
      expiry: _$JsonConverterFromJson<int, DateTime>(
          json['expiry'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$UserAccessInfoToJson(UserAccessInfo instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiry': _$JsonConverterToJson<int, DateTime>(
          instance.expiry, const DateTimeConverter().toJson),
      'flags': instance.flags,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
