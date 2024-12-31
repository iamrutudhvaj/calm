import 'package:calm/module/home/home_bloc/home_event.dart';
import 'package:calm/module/home/home_bloc/home_state.dart';
import 'package:calm/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;
  HomeBloc(this._userRepository) : super(HomeState()) {
    on<FetchUser>(_fetchUser);
    on<ClickDate>(_clickDate);
  }

  void _fetchUser(FetchUser event, Emitter<HomeState> emit) async {
    final user = await _userRepository.getUser();
    emit(state.copyWith(email: user?['email'], streak: user?['streak']));
  }

  void _clickDate(ClickDate event, Emitter<HomeState> emit) {
    List data = [];
    if (event.keep) {
      data = (state.streak..add(event.dateTime.toString())).toSet().toList();
    } else {
      data = state.streak;
      data.remove(event.dateTime.toString());
    }

    _userRepository.updateStreak(FirebaseAuth.instance.currentUser!.uid, data);
  }

  // get stream of user data from UserRepository
  Stream<Map<String, dynamic>?> userStream() {
    return _userRepository.userStream(FirebaseAuth.instance.currentUser!.uid);
  }
}
