import 'package:dio/dio.dart';
import 'package:khabar/api_services/model/news_model.dart';

class News {
  Future<NewsModel?> getNews(String category) async {
    Dio dio = Dio();
    var res = await dio.get(
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=f078e46f3a03493db681e040027eb2a0");
    if (res.statusCode == 200) {
      var model = NewsModel.fromJson(res.data);
      return model;
    } else {
      return null;
    }
  }
}
