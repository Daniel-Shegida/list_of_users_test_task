import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:list_of_users_test_task/data/models/user_dto.dart';
import 'package:list_of_users_test_task/data/models/users_search_dto.dart';
import 'package:retrofit/http.dart';

part 'git_data_source.g.dart';

/// remote datasource for getting users from github rest api
@RestApi()
@Singleton()
abstract class GitDataSource {
  /// getting dio from data/di/locator
  @factoryMethod
  factory GitDataSource(@Named('dio') Dio dio) =
  _GitDataSource;

  /// getting full info of user by id
  @GET('/user/{account_id}')
  Future<UserDto> fetchUserById(
      @Path('account_id') int accountId,
  );

  /// getting users without names, followers and etc
  @GET('/users')
  Future<List<UserDto>> fetchUsers(
      @Query("since") int? since,
      @Query("per_page") int? per_page,
  );

  /// search users without names, followers and etc
  /// return dto that contains users and incompleteResults flag
  @GET('/search/users')
  Future<UsersSearchDto> searchUsers
  (
  @Query("q") String search,
  @Query("page") int since,
  @Query("per_page") int? per_page,
  );
}
