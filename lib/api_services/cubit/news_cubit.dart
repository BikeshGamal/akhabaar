import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/api/news.dart';
import 'package:khabar/api_services/cubit/news_state.dart';
import 'package:khabar/constant/check_connectivity.dart';

class NewsCubit extends Cubit<CommonState> {
  NewsCubit() : super(CommonInitialState());
   getNews(bool showLoading,String? category) async
  {
    if(await isNetworkAvailable())
    {
      if(showLoading==true)
      {
      emit(CommonLoadingState());
      }
    News().getNews(category!).then((value) {
      emit(CommonSuccessState(newsModel: value!));
    }).onError((error, stackTrace) => null);
    }
    else{
      emit(NoNetworkState());
    }
  }
}