import 'package:clean_news_ai/data/dto/source.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

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
    @required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          runtimeType == other.runtimeType &&
          source == other.source &&
          author == other.author &&
          title == other.title &&
          description == other.description &&
          url == other.url &&
          urlToImage == other.urlToImage &&
          publishedAt == other.publishedAt &&
          content == other.content);

  @override
  int get hashCode =>
      source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;

  @override
  String toString() {
    return 'Article{' +
        ' source: $source,' +
        ' author: $author,' +
        ' title: $title,' +
        ' description: $description,' +
        ' url: $url,' +
        ' urlToImage: $urlToImage,' +
        ' publishedAt: $publishedAt,' +
        ' content: $content,' +
        '}';
  }

  Article copyWith({
    Source source,
    String author,
    String title,
    String description,
    String url,
    String urlToImage,
    String publishedAt,
    String content,
  }) {
    return Article(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  Map<String, Object> toMap() {
    return {
      'source': this.source,
      'author': this.author,
      'title': this.title,
      'description': this.description,
      'url': this.url,
      'urlToImage': this.urlToImage,
      'publishedAt': this.publishedAt,
      'content': this.content,
    };
  }

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
      publishedAt: time,
      content: map['content'] as String ?? '',
    );
  }
}
