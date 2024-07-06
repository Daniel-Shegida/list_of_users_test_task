import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_search_event.dart';
part 'users_search_state.dart';
part 'users_search_bloc.freezed.dart';

class UsersSearchBloc extends Bloc<UsersSearchEvent, UsersSearchState> {
  UsersSearchBloc() : super(const UsersSearchState.initial()) {
    on<UsersSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
