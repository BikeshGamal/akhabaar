import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khabar/api_services/model/news_model.dart';

class NewsRepository {
  final Dio dio;
  NewsRepository({required this.dio});
  Future<Either<String, NewsModel?>> getNews(String category) async {
    try {
      var res = await dio.get(
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0ccd783fa02041f0a6af8a46923ba931");
      if (res.statusCode == 200) {
        var model = NewsModel.fromJson(res.data);
        return Right(model);
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
