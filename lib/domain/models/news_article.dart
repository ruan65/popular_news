import 'dart:typed_data';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:flutter/cupertino.dart';

class ArticleModel {
  bool isSaved;
  final Article article;

  ArticleModel({
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
    return 'ArticleModel{' + ' isSaved: $isSaved,' + ' article: $article,' + '}';
  }

  ArticleModel copyWith({
    bool isSaved,
    Article article,
    Uint8List imageBytes,
  }) {
    return new ArticleModel(
      article: article ?? this.article,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSaved': this.isSaved,
      'article': this.article,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      article: map['article'] as Article,
    );
  }
}
