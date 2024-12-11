import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_access_info.g.dart';

/// 存储用户的登录信息
@JsonSerializable()
class UserAccessInfo {
  final String? token;

  @DateTimeConverter()
  final DateTime? expiry;

  final String? flags;

  UserAccessInfo({
    this.token,
    this.flags,
    this.expiry,
  });

  bool get validExpiry => expiry?.isAfter(DateTime.now()) ?? false;
  bool get hasToken => token != null;
  bool get hasExpiry => expiry != null;
  bool get hasFlags => flags != null;

  factory UserAccessInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAccessInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccessInfoToJson(this);

  factory UserAccessInfo.fromString(String? str) {
    final src = str == null || str.isEmpty ? '{}' : str;
    return UserAccessInfo.fromJson(jsonDecode(src) as Map<String, dynamic>);
  }
  @override
  String toString() => jsonEncode(toJson());
}

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();

  @override
  DateTime fromJson(int json) {
    return DateTime.fromMicrosecondsSinceEpoch(json);
  }

  @override
  int toJson(DateTime object) {
    return object.microsecondsSinceEpoch;
  }
}
