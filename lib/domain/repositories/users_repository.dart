
import 'package:list_of_users_test_task/domain/entity/user.dart';

/// repository for getting users from api
abstract class UsersRepository {
  /// get paginated list of users, page parameter - lastId
  Future<List<User>> getUserList({
    required int lastId,
    int pageSize = 20,
  });

  /// get paginated list of users, page parameter - page,
  /// return tuple
  /// 1 - isCompleteSearch flag
  /// 2 - list of users
  Future<(bool, List<User>)> searchUsers({
    required String search,
    required int page,
    int pageSize = 20,
  });
}
