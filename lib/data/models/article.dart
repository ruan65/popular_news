import 'package:clean_news_ai/data/models/source.dart';
import 'package:flutter/foundation.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
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

  Map<String, dynamic> toMap() {
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
    return Article(
      source: Source.fromMap(map['source']),
      author: map['author'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String,
      publishedAt: map['publishedAt'] as String,
      content: map['content'] as String,
    );
  }
}

//    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
//    DateTime unformedDate = format.parse(article["publishedAt"]);
//    _publishedAt = "${unformedDate.day} ${months[unformedDate.month - 1]} ${unformedDate.year}";
