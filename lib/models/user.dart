import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required int age,
    //@JsonKey 讓你可以在 Dart 程式碼中使用符合慣例的駝峰式命名，同時正確對應到後端 API 的蛇形命名。
    //不需要手動轉換命名格式
    @JsonKey(name: 'is_vip') @Default(false) bool isVip,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}