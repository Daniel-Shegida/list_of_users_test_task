import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_users_test_task/di/locator.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/bloc/users_search_bloc.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/widgets/empty_widget.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/widgets/filter_switcher.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/widgets/users_list.dart';

class UsersSearchPage extends StatelessWidget {
  const UsersSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        return getIt.get<UsersSearchBloc>()
          ..add(const UsersSearchEvent.loadMore());
      },
      child: BlocBuilder<UsersSearchBloc, UsersSearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: AnimatedSearchBar(
                label: 'Project for Tark team',
                labelAlignment: Alignment.center,
                onChanged: (value) {
                  context.read<UsersSearchBloc>().add(
                        UsersSearchEvent.search(search: value),
                      );
                },
                onFieldSubmitted: (_) {},
                onClose: () {
                  context.read<UsersSearchBloc>().add(
                        const UsersSearchEvent.finishSearch(),
                      );
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Column(
                children: [
                  FilterSwitcher(
                    currentValue: state.filterValue,
                    isVisible: state.isFilerVisible,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state.map(
                    loaded: (loaded) {
                      return UsersList(
                        users: loaded.users,
                        isLast: loaded.isLast,
                      );
                    },
                    empty: (empty) {
                      return EmptyWidget(
                        text: empty.emptyMessage,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
