//import 'package:clean_news_ai/domain/middleware/favorite.dart';
//import 'package:clean_news_ai/domain/middleware/topNewsMiddleware.dart';
//import 'package:clean_news_ai/domain/states/top_news_state.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:osam/domain/store/store.dart';
//
//void main() {
//  test('top news', () async {
//    final store =
//        Store(states: [TopNewsState()], middleWares: [TopNewsMiddleware(), FavoriteMiddleware()]);
//  });
//
////  test('everything', () async {
////    final results = <Article>[];
////    (await NetworkDataRepository().searchArticles(keyWord: 'google')).listen((data) {
////      results.addAll(data);
////      expect(results, isA<List<Article>>());
////      expect(results, isNotEmpty);
////    });
////  });
//}
