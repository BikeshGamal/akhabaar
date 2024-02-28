import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/news_state.dart';
import 'package:khabar/api_services/repository/news_repostiory.dart';

class BreakingCubit extends Cubit<CommonState> {
  final NewsRepository repository;
  BreakingCubit({required this.repository}) : super(CommonInitialState());
  Future<bool> _isNetworkAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  getNews(bool showLoading, String category) async {
    if (await _isNetworkAvailable()) {
      if (showLoading == true) {
        emit(CommonLoadingState());
      }
      final res = await repository.getNews(category);
      res.fold((err) => emit(CommonErrorState()),
          (data) => emit(CommonSuccessState(newsModel: data!)));
    } else {
      emit(NoNetworkState());
    }
  }
}
