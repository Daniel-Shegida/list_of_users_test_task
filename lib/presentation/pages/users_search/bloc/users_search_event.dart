part of 'users_search_bloc.dart';

@freezed
class UsersSearchEvent with _$UsersSearchEvent {
  const factory UsersSearchEvent.loadMore() = _LoadMore;

  const factory UsersSearchEvent.search({required String search}) = _Search;

  const factory UsersSearchEvent.finishSearch() = _FinishSearch;

  const factory UsersSearchEvent.changeFilter({required SearchFilters filter}) =
      _ChangeFilter;
}
