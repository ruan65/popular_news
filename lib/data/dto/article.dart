import 'package:clean_news_ai/data/dto/source.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'article.g.dart';

@HiveType()
class Article {
  @HiveField(0)
  final Source source;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String urlToImage;
  @HiveField(6)
  final String publishedAt;
  @HiveField(7)
  final String content;

  const Article({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    this.content = '',
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateTime unformedDate = format.parse(map['publishedAt'] as String ?? '');
    final hoursNumber = DateTime.now().difference(unformedDate).inHours;
    final lastNumber = hoursNumber % 10;
    String time;
    if (lastNumber < 2) {
      time = hoursNumber.toString() + ' час назад';
    } else if (lastNumber < 5) {
      time = hoursNumber.toString() + ' часa назад';
    } else {
      time = hoursNumber.toString() + ' часов назад';
    }
    return Article(
      source: Source.fromMap(map['source']),
      author: map['author'] as String ?? '',
      title: map['title'] as String ?? '',
      description: map['description'] as String ?? '',
      url: map['url'] as String ?? '',
      urlToImage: map['urlToImage'] as String ?? '',
      publishedAt: time ?? '',
      content: map['content'] as String ?? '',
    );
  }
}
