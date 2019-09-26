import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/data/network_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('top news', () async {
    final results = <Article>[];
    (await NetworkDataRepository().getTopArticles(category: 'sport')).listen((data) {
      results.addAll(data);
      expect(results, isA<List<Article>>());
      expect(results, isNotEmpty);
    });
  });

  test('everything', () async {
    final results = <Article>[];
    (await NetworkDataRepository().searchArticles(keyWord: 'google')).listen((data) {
      results.addAll(data);
      expect(results, isA<List<Article>>());
      expect(results, isNotEmpty);
    });
  });
}
