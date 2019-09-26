import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import 'domain/domain_repository.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  @override
  ExampleState get initialState => InitialExampleState();
  //currentState ??

  InitialExampleState currentState;

  @override
  Stream<ExampleState> mapEventToState(
    ExampleEvent event,
  ) async* {
    final articles = await (await DomainRepository().getTopArticles(category: 'sport')).first;
    ExampleState.initial().articles.clear();
    // currentState = ExampleState.initial()..articles.addAll(articles);
    yield ExampleState.initial()..articles.addAll(articles);
  }
}
