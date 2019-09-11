import 'package:clean_news_ai/data/data_repository.dart';
import 'package:clean_news_ai/data/models/article.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('top news', () async {
    final results = <Article>[];
    (await DataRepository().getTopArticles(category: 'sport')).listen((data) {
      results.addAll(data);
      expect(results, isA<List<Article>>());
      expect(results, isNotEmpty);
    });
  });

  test('everything', () async {
    final results = <Article>[];
    (await DataRepository().searchArticles(keyWord: 'google')).listen((data) {
      results.addAll(data);
      expect(results, isA<List<Article>>());
      expect(results, isNotEmpty);
    });
  });
}
