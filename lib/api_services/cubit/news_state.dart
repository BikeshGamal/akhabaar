import 'package:khabar/api_services/model/news_model.dart';

class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonErrorState extends CommonState {
  final String msg;
  CommonErrorState({required this.msg});
}


class CommonSuccessState extends CommonState {
  final List<Articles?> newsModel;
  CommonSuccessState({required this.newsModel});
}
