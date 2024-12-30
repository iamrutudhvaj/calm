import 'package:equatable/equatable.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();
  @override
  List<Object> get props => [];
}

/// UPDATE intex
class UpdateIntroIndex extends IntroEvent {
  final int newIndex;

  const UpdateIntroIndex(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}

