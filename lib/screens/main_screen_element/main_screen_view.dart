
import 'package:clean_news_ai/screens/abstracts/abstract_view.dart';
import 'main_screen_mutator.dart';
import 'main_screen_state.dart';

class MainScreenView extends AbstractScreenView {
  MainScreenView(mutator, title, state) : super(mutator, title, state, false);
}
final mainScreenView = MainScreenView(mainMutator, "Hot News", state);