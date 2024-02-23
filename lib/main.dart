import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/api_services/cubit/cnews_cubit.dart';
import 'package:khabar/api_services/cubit/news_cubit.dart';
import 'package:khabar/api_services/cubit/tnews_cubit.dart';
import 'package:khabar/screen/splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getNews(true, "science"),
        ),
        BlocProvider(
          create: (context) => TnewsCubit()..getNews(false, "technology")
        ),
         BlocProvider(
          create: (context) => CnewsCubit()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
