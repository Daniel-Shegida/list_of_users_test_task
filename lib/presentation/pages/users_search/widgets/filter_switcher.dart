import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_users_test_task/domain/enums/search_filters.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/bloc/users_search_bloc.dart';

/// widget of choosing search filter for bloc,
/// if isVisible = false - became transparent and 1 px height
class FilterSwitcher extends StatelessWidget {
  final SearchFilters currentValue;
  final bool isVisible;

  const FilterSwitcher({
    required this.currentValue,
    required this.isVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(
        milliseconds: 250,
      ),
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(
          milliseconds: 250,
        ),
        child: SizedBox(
          height: isVisible ? 40 : 1,
          child: AnimatedToggleSwitch<SearchFilters>.size(
            textDirection: TextDirection.ltr,
            allowUnlistedValues: true,
            current: currentValue,
            values: const [
              SearchFilters.ah,
              SearchFilters.ip,
              SearchFilters.qz,
            ],
            iconOpacity: 0.2,
            indicatorSize: const Size.fromWidth(150),
            iconBuilder: (value) => Text(
              value.name,
            ),
            borderWidth: 4,
            iconAnimationType: AnimationType.onHover,
            style: ToggleStyle(
              indicatorColor: Theme.of(context).primaryColor,
              borderColor: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            onChanged: (i) {
              context.read<UsersSearchBloc>().add(
                    UsersSearchEvent.changeFilter(filter: i),
                  );
            },
          ),
        ),
      ),
    );
  }
}
