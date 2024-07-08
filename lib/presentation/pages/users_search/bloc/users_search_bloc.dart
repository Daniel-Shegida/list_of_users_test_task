import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:list_of_users_test_task/domain/entity/user.dart';
import 'package:list_of_users_test_task/domain/enums/search_filters.dart';
import 'package:list_of_users_test_task/domain/repositories/users_repository.dart';

part 'users_search_bloc.freezed.dart';

part 'users_search_event.dart';

part 'users_search_state.dart';

/// bloc that supports searching users and filter users
@injectable
class UsersSearchBloc extends Bloc<UsersSearchEvent, UsersSearchState> {
  final UsersRepository _usersRepository;

  /// list of SearchFilters.ah
  final List<User> _firstFilteredUsers = [];

  /// list of SearchFilters.ip
  final List<User> _secondFilteredUsers = [];

  /// list of SearchFilters.qz
  final List<User> _thirdFilteredUsers = [];

  /// list of searching users
  final List<User> _listOfSearchUsers = [];

  /// getters that return one of users list depending on currentFilter
  List<User> get users {
    switch (currentFilter) {
      case SearchFilters.ah:
        return _firstFilteredUsers;
      case SearchFilters.ip:
        return _secondFilteredUsers;
      case SearchFilters.qz:
        return _thirdFilteredUsers;
      default:
        return [];
    }
  }

  /// page parameter for filter req
  int _lastId = 0;

  /// page parameter for search
  int searchPage = 0;

  /// current state of filter
  SearchFilters currentFilter = SearchFilters.ah;

  /// is needed to show filter filter
  bool isFilterVisible = true;

  /// search parameter for search
  String lastSearch = '';

  /// does search meet end
  bool isSearchCompleted = false;

  UsersSearchBloc(
    this._usersRepository,
  ) : super(const UsersSearchState.empty(
          isFilerVisible: false,
        )) {
    on<_LoadMore>(_onLoadMore);
    on<_ChangeFilter>(_onChangeFilter);
    on<_Search>(_onSearch, transformer: restartable());
    on<_FinishSearch>(_onFinishSearch);
  }

  Future<void> _onSearch(_Search event, Emitter<UsersSearchState> emit) async {
    /// clear all values and prepare screen for search
    currentFilter = SearchFilters.empty;
    lastSearch = event.search;
    _listOfSearchUsers.clear();
    isFilterVisible = false;
    isSearchCompleted = false;
    searchPage = 1;
    emit(
      _Empty(
        isFilerVisible: isFilterVisible,
        filterValue: currentFilter,
      ),
    );

    /// fetch users
    if (event.search.isNotEmpty) {
      final result = await _searchUsers(searchPage);

      ///  close this one  if new search event is pushed
      if (emit.isDone) {
        return;
      }

      /// gets values from api req
      searchPage++;
      isSearchCompleted = result.$1;

      /// if results is not empty show users
      if (result.$2.isNotEmpty) {
        _listOfSearchUsers.addAll(result.$2);
        emit(
          _Loaded(
            users: _listOfSearchUsers,
            isFilerVisible: isFilterVisible,
            filterValue: currentFilter,
            isLast: isSearchCompleted,
          ),
        );

        /// if results is empty show emptyMessage
      } else {
        emit(
          _Empty(
            emptyMessage: 'No users found',
            isFilerVisible: isFilterVisible,
            filterValue: currentFilter,
          ),
        );
      }

      /// if search is empty show emptyMessage
    } else {
      emit(
        _Empty(
          emptyMessage: 'Please enter request',
          isFilerVisible: isFilterVisible,
          filterValue: currentFilter,
        ),
      );
    }
  }

  /// event when close search bar, returns filter
  Future<void> _onFinishSearch(
      _FinishSearch event, Emitter<UsersSearchState> emit) async {
    if (currentFilter == SearchFilters.empty) {
      isFilterVisible = true;
      currentFilter = SearchFilters.ah;
      emit(
        _Loaded(
          users: users,
          filterValue: currentFilter,
        ),
      );
    }
  }

  /// event for loading more users for search and filter req
  Future<void> _onLoadMore(
      _LoadMore event, Emitter<UsersSearchState> emit) async {
    /// filter logic
    if (isFilterVisible) {
      final newUsers = await _usersRepository.getUserList(
        lastId: _lastId,
        pageSize: 50,
      );
      _lastId = newUsers.last.id;

      /// filter users for each SearchFilters regExp
      for (final user in newUsers) {
        if (RegExp(SearchFilters.ah.regExp)
            .hasMatch(user.name.split(' ').first.toLowerCase())) {
          _firstFilteredUsers.add(user);
          continue;
        }
        if (RegExp(SearchFilters.ip.regExp)
            .hasMatch(user.name.split(' ').first.toLowerCase())) {
          _secondFilteredUsers.add(user);
          continue;
        }
        if (RegExp(SearchFilters.qz.regExp)
            .hasMatch(user.name.split(' ').first.toLowerCase())) {
          _thirdFilteredUsers.add(user);
          continue;
        }
      }

      emit(
        _Loaded(
          users: users,
          refreshValue: DateTime.now(),
          filterValue: currentFilter,
          isFilerVisible: isFilterVisible,
        ),
      );

      /// search logic
    } else {
      final result = await _searchUsers(searchPage);
      searchPage++;
      isSearchCompleted = result.$1;
      _listOfSearchUsers.addAll(result.$2);
      emit(
        _Loaded(
          users: _listOfSearchUsers,
          refreshValue: DateTime.now(),
          filterValue: currentFilter,
          isFilerVisible: isFilterVisible,
        ),
      );
    }
  }

  /// event when user change filter
  Future<void> _onChangeFilter(
      _ChangeFilter event, Emitter<UsersSearchState> emit) async {
    emit(
      _Empty(
        filterValue: event.filter,
      ),
    );
    currentFilter = event.filter;

    /// waiting is necessary to refresh position of user list
    await Future.delayed(const Duration(milliseconds: 125));

    emit(
      _Loaded(
        users: users,
        refreshValue: DateTime.now(),
        filterValue: currentFilter,
      ),
    );
  }

  /// decoration for searching users
  Future<(bool, List<User>)> _searchUsers(int page) async {
    return _usersRepository.searchUsers(
      search: lastSearch,
      page: page,
      pageSize: 50,
    );
  }
}
