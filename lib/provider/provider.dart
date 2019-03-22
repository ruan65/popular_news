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
  final _prefs = SharedPreferences.getInstance();
  final _fireStore = Firestore.instance;

  getNews(search, theme) async {
    var response;
    final _apiKey = apikeys[Random().nextInt(4)];
    final lastRequest = (await _prefs).getString('lastRequest');
    final mapArticles = {};

    final platform = const MethodChannel('samples.flutter.io/battery');
    var lang = await platform.invokeMethod('lang');

    if (search) {
      response = await get(
          "https://newsapi.org/v2/everything?q=$lastRequest&pageSize=1&sortBy=relevance&language=$lang&apiKey=$_apiKey");
    } else {
      lang == "en" ? lang = "us" : (await _prefs).getString('lang');
      response = await get(
              "https://newsapi.org/v2/top-headlines?country=$lang&category=$theme&pageSize=1&apiKey=$_apiKey");
    }
    
    if (response.statusCode != 200) return getNews(search, theme);

    final articles = ItemModel.fromJson(json.decode(response.body)).articles;

    for (Article article in articles) {
      if(article.urlToImage != null)
        mapArticles[article.url] = article;
    }
    final savedArticles = await getSavedNews();
    for (String key in savedArticles.keys) {
      if (mapArticles.containsKey(key)) {
        mapArticles[key].liked = true;
      }
    }
    return mapArticles;
  }

  getSavedNews() async {
    final uuid = await showMyID();
    final mapSavedArticles = {};
    var articles = await _fireStore.collection("users").document(uuid).get();
    if (articles.data != null) {
      articles.data.values.toList().forEach((value) {
        var article = Article.fromMap(value);
        mapSavedArticles[article.url] = article;
        mapSavedArticles[article.url].liked = true;
      });
    }
    return mapSavedArticles;
  }

  uploadMyArticle(holder) async {
    final key = holder["url"].replaceAll(RegExp(r"[/.]"), "");
    final uuid = await showMyID();
    _fireStore
        .collection("users")
        .document(uuid)
        .setData({key: holder}, merge: true);
  }

  deleteMyArticle(url) async {
    final key = url.replaceAll(RegExp(r"[/.]"), "");
    final uuid = await showMyID();
    _fireStore
        .collection("users")
        .document(uuid)
        .updateData({key: FieldValue.delete()});
  }

  showMyID() async {
    (await _prefs).getString('id') ?? _saveMyID();
    return (await _prefs).getString('id');
  }

  _saveMyID() async {
    final myid = Uuid().v4();
    await _fireStore.collection("users").document(myid).get();
    (await _prefs).setString('id', myid);
  }

  isReadyToUpdate() async {
    await _fireStore.settings(timestampsInSnapshotsEnabled: true);
    var newVersionDoc =
        await _fireStore.collection("appInfo").document("flutterNews").get();
    int newVersion = newVersionDoc.data.values.toList()[0];
    return newVersion > 5;
  }
}

final provider = NewsApiProvider();
