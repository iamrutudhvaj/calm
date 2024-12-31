import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List streak;
  final String email;

  const HomeState({
    this.streak = const [],
    this.email = '',
  });

  HomeState copyWith({List? streak, String? email}) =>
      HomeState(streak: streak ?? this.streak, email: email ?? this.email);

  @override
  String toString() => 'HomeState($streak, $email)';

  @override
  List<Object> get props => [];
}
