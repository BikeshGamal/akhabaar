import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khabar/api_services/model/news_model.dart';

class NewsRepository {
  final Dio dio;
  List<Articles> _news = [];
  List<Articles> _snews = [];
  List<Articles> _tnews = [];

  NewsRepository({required this.dio});
  Future<Either<String, List<Articles>?>> getNews(String category) async {
    try {
      var isCacheExists = await APICacheManager().isAPICacheKeyExist("NEWS");
      if (isCacheExists) {
        var cacheData = await APICacheManager().getCacheData("NEWS");
        var model = json.decode(cacheData.syncData);
        return Right(model);
      }

      var res = await dio.get(
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=f078e46f3a03493db681e040027eb2a0");
      if (res.statusCode == 200) {
        APICacheDBModel cacheDBModel = APICacheDBModel(
            key: "NEWS", syncData: json.encode(res.data));
        await APICacheManager().addCacheData(cacheDBModel);
        var model = NewsModel.fromJson(res.data);
        if (model.articles != null) {
          var newsList = model.articles!.toList();
          if (category == "science") {
            _snews.clear();
            _snews.addAll(newsList);
            return Right(_snews);
          }
          if (category == "technology") {
            _tnews.clear();
            _tnews.addAll(newsList);
            return Right(_tnews);
          }
          _news.clear();
          _news.addAll(newsList);
          return Right(_news);
        } else {
          return Right([]);
        }
      } else {
        return Right(null);
      }
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch news");
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
