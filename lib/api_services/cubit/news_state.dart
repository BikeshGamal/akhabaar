import 'package:khabar/api_services/model/news_model.dart';

class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonErrorState extends CommonState {}

class NoNetworkState extends CommonState {}

class CommonSuccessState extends CommonState {
  final NewsModel newsModel;
  CommonSuccessState({required this.newsModel});
}
