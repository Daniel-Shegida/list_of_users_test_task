part of 'users_search_bloc.dart';

@freezed
class UsersSearchEvent with _$UsersSearchEvent {
  const factory UsersSearchEvent.started() = _Started;
}
