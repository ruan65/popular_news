import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:clean_news_ai/models/Item_model.dart';
import 'package:clean_news_ai/provider/keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class NewsApiProvider {
  final prefs = SharedPreferences.getInstance();
  final _fireStore = Firestore.instance..enablePersistence(true);
  final platform = const MethodChannel('samples.flutter.io/battery');

  Map<String, Article> mapArticles = {};
  Map<String, Article> savedArticles;

  var uid;

  Future<Map<String, Article>> getNews({bool search, String theme}) async {
    final _apiKey = apikeys[Random().nextInt(4)];
    final lastRequest = (await prefs).getString('lastRequest') ??
        "12138172827816372163761263126";
    var lang = await platform.invokeMethod('lang');

    Response response;

    if (search) {
      response = await get(
          "https://newsapi.org/v2/everything?q=$lastRequest&pageSize=100&sortBy=relevance&language=$lang&apiKey=$_apiKey");
    } else {
      if (lang == "en") lang = "us";
      response = await get(
          "https://newsapi.org/v2/top-headlines?country=$lang&category=$theme&pageSize=100&apiKey=$_apiKey");
    }

    if (response.statusCode != 200)
      return await getNews(search: search, theme: theme);
    final List<Article> articles =
        ArticleModel.fromJson(json.decode(response.body)).articles;

    mapArticles = {};
    savedArticles = savedArticles ?? await getSavedNews();
    articles.forEach((article) {
      if (savedArticles.containsKey(article.url)) article.liked = true;
      mapArticles[article.url] = article;
    });

    return mapArticles;
  }

  Future<Map<String, Article>> getSavedNews() async {
    uid = uid ?? await showMyID();
    savedArticles = {};
    DocumentSnapshot articles =
        await _fireStore.collection("users").document(uid).get();
    if (articles.data != null)
      articles.data.values.toList().forEach((value) {
        Article article = Article.fromMap(value);
        savedArticles[article.url] = article..liked = true;
      });
    return savedArticles;
  }

  uploadMyArticle({Map holder}) async {
    final key = holder["url"].replaceAll(RegExp(r"[/.]"), "");
    _fireStore
        .collection("users")
        .document(uid)
        .setData({key: holder}, merge: true);
  }

  deleteMyArticle({String url}) async {
    final key = url.replaceAll(RegExp(r"[/.]"), "");
    _fireStore
        .collection("users")
        .document(uid)
        .updateData({key: FieldValue.delete()});
  }

  Future<String> showMyID() async {
    (await prefs).getString('id') ?? _saveMyID();
    return (await prefs).getString('id');
  }

  _saveMyID() async {
    final myid = Uuid().v4();
    await _fireStore.collection("users").document(myid).get();
    (await prefs).setString('id', myid);
  }

  Future<bool> isReadyToUpdate() async {
    await _fireStore.settings(timestampsInSnapshotsEnabled: true);
    var newVersionDoc =
        await _fireStore.collection("appInfo").document("flutterNews").get();
    int newVersion = newVersionDoc.data.values.toList()[0];
    return newVersion > 13;
  }
}

final provider = NewsApiProvider();
