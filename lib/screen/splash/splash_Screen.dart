import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/constant/const.dart';
import 'package:khabar/screen/home/home_screen.dart';
import 'splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final splashCubit = BlocProvider.of<SplashCubit>(context);
    Future.delayed(Duration(seconds: 5), () {
      splashCubit.navigateToHome();
    });

    return BlocListener<SplashCubit, bool>(
      listener: (context, state) {
        if (!state) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Image(image: AssetImage(Const.splash)),
          ),
        ),
      ),
    );
  }
}
