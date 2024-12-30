import 'package:equatable/equatable.dart';

class IntroState extends Equatable {
  final int selectedIndex;
  const IntroState({
    this.selectedIndex = 0,
  });

  IntroState copyWith({
    int? selectedIndex,
  }) {
    return IntroState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  String toString() {
    return 'IntroState(selectedIndex: $selectedIndex)';
  }

  @override
  List<Object> get props => [selectedIndex];
}
