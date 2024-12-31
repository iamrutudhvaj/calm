import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// fetch user
class FetchUser extends HomeEvent {}

// click on date
class ClickDate extends HomeEvent {
  final DateTime dateTime;
  final bool keep;

  ClickDate(this.dateTime, this.keep);

  @override
  List<Object> get props => [dateTime, keep];
}
