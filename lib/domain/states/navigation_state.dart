import 'package:osam/osam.dart';

// ignore: must_be_immutable
class NavigationState extends BaseState<NavigationState> {
  int navigationIndex = 0;

  void routeTo(int index) => navigationIndex = index;

  @override
  List<Object> get props => [navigationIndex];
}
