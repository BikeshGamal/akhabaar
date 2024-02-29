import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/news_state.dart';
import 'package:khabar/api_services/repository/news_repostiory.dart';

class NewsCubit extends Cubit<CommonState> {
  final NewsRepository repository;
  NewsCubit({required this.repository}) : super(CommonInitialState());
 
  getNews(bool showLoading, String category) async {
      if (showLoading == true) {
        emit(CommonLoadingState());
      }
      final res = await repository.getNews(category);
      res.fold((err) => emit(CommonErrorState(msg: err)),
          (data) => emit(CommonSuccessState(newsModel: data!)));
  }
}
