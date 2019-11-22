import 'package:hive/hive.dart';
import 'package:osam/osam.dart';

part 'navigation_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class NavigationState extends BaseState<NavigationState> {
  @HiveField(0)
  int navigationIndex = 0;

  void routeTo(int index) => navigationIndex = index;

  @override
  List<Object> get props => [navigationIndex];
}
