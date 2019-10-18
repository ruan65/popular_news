//import 'package:clean_news_ai/data/api/news_api.dart';
//import 'package:clean_news_ai/data/dto/article/article.dart';
//import 'package:clean_news_ai/data/network_data_repository.dart';
//import 'package:flutter_test/flutter_test.dart';
//
//void main() {
//  test('top news', () async {
//    final json = await API().getTopArticles(category: 'sport').catchError((error) {
//      throw error;
//    });
//    final result = NetworkDataRepository.parseArticles(json);
//    expect(result, isA<List<Article>>());
//    expect(result, isNotEmpty);
//  });
//
//  test('everything', () async {
//    final json = await API().searchArticles(keyWord: 'google');
//    final result = NetworkDataRepository.parseArticles(json);
//    expect(result, isA<List<Article>>());
//    expect(result, isNotEmpty);
//  });
//}
