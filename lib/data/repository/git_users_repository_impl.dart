import 'package:injectable/injectable.dart';
import 'package:list_of_users_test_task/data/datasourse/git_data_source.dart';
import 'package:list_of_users_test_task/data/models/user_dto.dart';
import 'package:list_of_users_test_task/domain/entity/user.dart';
import 'package:list_of_users_test_task/domain/repositories/users_repository.dart';

/// repository for getting users from github rest api
@Singleton(as: UsersRepository)
class GitUsersRepositoryImpl implements UsersRepository {
  final GitDataSource _gitDataSource;

  GitUsersRepositoryImpl(
    this._gitDataSource,
  );

  /// get paginated list of users, page parameter - lastId
  @override
  Future<List<User>> getUserList({
    required int lastId,
    int pageSize = 20,
  }) async {
    /// getting list of users without full information
    final users = await _gitDataSource.fetchUsers(
      lastId,
      pageSize,
    );
    /// adding for each user nickname, followers and following
    for (var i = 0; i < users.length; i++) {
      users[i] = await _gitDataSource.fetchUserById(
        users[i].id!,
      );
    }

    return users.map((userDto) => userDto.toModel).toList();
  }

  /// get paginated list of users, page parameter - page,
  /// return tuple
  /// 1 - isCompleteSearch flag
  /// 2 - list of users
  @override
  Future<(bool, List<User>)> searchUsers({
    required String search,
    required int page,
    int pageSize = 20,
  }) async {
    /// getting list of users without full information
    final result = await _gitDataSource.searchUsers(
      '$search in:name',
      page,
      pageSize,
    );

    /// adding for each user nickname, followers and following
    final users = result.items.toList();
    for (var i = 0; i < result.items.length; i++) {
      users[i] = await _gitDataSource.fetchUserById(
        users[i].id!,
      );
    }
    return (
      result.incompleteResults,
      users.map((userDto) => userDto.toModel).toList()
    );
  }
}
