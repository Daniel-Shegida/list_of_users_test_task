import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String avatarUrl,
    required String login,
    required String name,
    required int followers,
    required int following,
  }) = _User;
}
