import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:list_of_users_test_task/data/models/user_dto.dart';

part 'users_search_dto.freezed.dart';

part 'users_search_dto.g.dart';

/// dto model for geting users from search in github api
@freezed
abstract class UsersSearchDto with _$UsersSearchDto {
  const factory UsersSearchDto({
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    required List<UserDto> items,
  }) = _UsersSearchDto;

  factory UsersSearchDto.fromJson(Map<String, dynamic> json) =>
      _$UsersSearchDtoFromJson(json);
}

