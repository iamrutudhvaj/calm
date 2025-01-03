import 'package:bloc/bloc.dart';
import 'package:calm/module/introduction/intro_bloc/intro_event.dart';
import 'package:calm/module/introduction/intro_bloc/intro_state.dart';
import 'package:calm/utils/extentions.dart';
import 'package:flutter/material.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroState(selectedIndex: 0)) {
    on<UpdateIntroIndex>(_updateIntroIndex);
  }

  PageController pageController = PageController(
    initialPage: 0,
  );

  void _updateIntroIndex(UpdateIntroIndex event, Emitter<IntroState> emit) {
    pageController.animateToPage(event.newIndex,
        duration: 300.milliseconds, curve: Curves.linear);
    emit(state.copyWith(selectedIndex: event.newIndex));
  }
}
