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
      var res = await dio.get(
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0ccd783fa02041f0a6af8a46923ba931");
      if (res.statusCode == 200) {
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
      return Left(e.response?.data["message"] ?? "unable to fetch news");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
