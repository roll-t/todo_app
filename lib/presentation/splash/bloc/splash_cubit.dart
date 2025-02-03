import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  void showSplash() {
    emit(true);
    Future.delayed(const Duration(seconds: 0), () {
      emit(false);
    });
  }
}
