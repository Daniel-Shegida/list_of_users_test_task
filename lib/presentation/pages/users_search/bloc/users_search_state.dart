part of 'users_search_bloc.dart';

@freezed
class UsersSearchState with _$UsersSearchState {
  /// state when bloc has items to show
  const factory UsersSearchState.loaded({
    @Default([]) List<User> users,

    /// do we need to load new pages
    @Default(false) bool isLast,

    /// position of filter
    @Default(SearchFilters.empty) SearchFilters filterValue,

    /// hide or not filter
    @Default(true) bool isFilerVisible,

    /// just refresh value, when we need to force to build new state
    DateTime? refreshValue,
  }) = _Loaded;

  /// state for showing messages or loading
  const factory UsersSearchState.empty({
    /// position of filter
    @Default(SearchFilters.empty) SearchFilters filterValue,

    /// hide or not filter
    @Default(true) bool isFilerVisible,

    /// message to show
    String? emptyMessage,
  }) = _Empty;
}
