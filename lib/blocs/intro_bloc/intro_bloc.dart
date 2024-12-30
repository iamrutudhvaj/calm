import 'package:bloc/bloc.dart';
import 'package:calm/blocs/intro_bloc/intro_event.dart';
import 'package:calm/blocs/intro_bloc/intro_state.dart';
import 'package:flutter/material.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroState(selectedIndex: 0)) {
    on<UpdateIntroIndex>(_updateIntroIndex);
  }

  PageController pageController = PageController(
    initialPage: 0,
  );

  void _updateIntroIndex(UpdateIntroIndex event, Emitter<IntroState> emit) {
    pageController.jumpToPage(event.newIndex);
    emit(state.copyWith(selectedIndex: event.newIndex));
  }
}
