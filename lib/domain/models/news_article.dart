import 'package:clean_news_ai/data/dto/article.dart';
import 'package:flutter/foundation.dart';

class ArticleModel {
  final bool isSaved;
  final Article article;

  const ArticleModel({
    @required this.isSaved,
    @required this.article,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleModel &&
          runtimeType == other.runtimeType &&
          isSaved == other.isSaved &&
          article == other.article);

  @override
  int get hashCode => isSaved.hashCode ^ article.hashCode;

  @override
  String toString() {
    return 'NewsArticle{' + ' isSaved: $isSaved,' + ' article: $article,' + '}';
  }

  ArticleModel copyWith({
    bool isSaved,
    Article article,
  }) {
    return ArticleModel(
      isSaved: isSaved ?? this.isSaved,
      article: article ?? this.article,
    );
  }

  Map<String, Object> toMap() {
    return {
      'isSaved': this.isSaved,
      'article': this.article,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      isSaved: map['isSaved'] as bool,
      article: map['article'] as Article,
    );
  }
}
