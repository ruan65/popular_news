import 'package:intl/intl.dart';

class ItemModel {
  List<Article> _articles = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Article> temp = [];
    for (int i = 0; i < parsedJson['articles'].length; i++) {
      Article article = Article(parsedJson['articles'][i]);
      temp.add(article);
    }
    _articles = temp;
  }

  List<Article> get articles => _articles;
}

class Article {
  Map _source;
  String _author;
  String _title;
  String _description;
  String _url;
  String _urlToImage;
  String _publishedAt;
  String _content;
  bool liked = false;

  Article(article) {
    _source = article["source"];
    _author = article["author"];
    _title = article["title"];
    _description = article["description"];
    _url = article["url"];
    _urlToImage = article["urlToImage"];
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final unformedDate = format.parse(article["publishedAt"]);
    _publishedAt =
        "${unformedDate.day} ${months[unformedDate.month - 1]} ${unformedDate.year}";
    _content = article["content"];
  }

  Article.fromMap(map) {
    _source = {"name": map["name"]};
    _author = "nothing";
    _title = map["title"];
    _description = "nothing";
    _url = map["url"];
    _urlToImage = map["urlToImage"];
    _publishedAt = map["publishedAt"];
    _content = map["content"];
  }

  get source => _source;
  get author => _author;
  get title => _title;
  get description => _description;
  get url => _url;
  get urlToImage => _urlToImage;
  get publishedAt => _publishedAt;
  get content => _content;

  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
}
