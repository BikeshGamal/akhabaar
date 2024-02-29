import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/news_cubit.dart';
import 'package:khabar/api_services/repository/news_repostiory.dart';
import 'package:khabar/screen/splash/splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    return RepositoryProvider(
      create: (context) => NewsRepository(dio: dio),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                NewsCubit(repository: context.read<NewsRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
