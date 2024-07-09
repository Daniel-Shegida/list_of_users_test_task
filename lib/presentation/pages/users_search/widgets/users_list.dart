import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_users_test_task/domain/entity/user.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/bloc/users_search_bloc.dart';
import 'package:paginated_list/paginated_list.dart';

/// widget of list of users from bloc
/// supports automatic pagination, request new users at the bottom of list
/// when isLast - true - loadingIndicator is not showing
class UsersList extends StatelessWidget {
  final List<User> users;
  final bool isLast;

  const UsersList({
    required this.users,
    required this.isLast,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PaginatedList<User>(
        loadingIndicator: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              ),
        addAutomaticKeepAlives: false,
        items: users,
        isRecentSearch: false,
        isLastPage: isLast,
        onLoadMore: (index) => context
                .read<UsersSearchBloc>()
                .add(const UsersSearchEvent.loadMore()),
        builder: (user, index) => _UserCard(
          user: user,
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final User user;

  const _UserCard({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.name),
        subtitle: Text('${user.followers} / ${user.following}'),
      ),
    );
  }
}
