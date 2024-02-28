import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(true);

  void navigateToHome() {
    emit(false);
  }
}
