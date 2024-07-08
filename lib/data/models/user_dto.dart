import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:list_of_users_test_task/domain/entity/user.dart';

part 'user_dto.freezed.dart';

part 'user_dto.g.dart';

/// dto model for geting users from github api
@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    int? id,
    String? login,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? name,
    int? followers,
    int? following,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension ConversationAttributesGetter on UserDto {
  /// get user from userDto
  User get toModel => User(
        id: id!,
        avatarUrl: avatarUrl!,
        login: login ?? '',
        name: name ?? '',
        followers: followers ?? 0,
        following: following ?? 0,
      );
}
