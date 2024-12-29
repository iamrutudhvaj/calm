import 'package:bloc/bloc.dart';
import 'package:calm/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc(this._userRepository) : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await _userRepository.getProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final updatedProfile = await _userRepository.updateProfile(event.profile);
        emit(ProfileLoaded(updatedProfile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}


