import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);


  void loadData() {
    // Simulate loading data
    Future.delayed(const Duration(seconds: 5), () {
      emit(true);
    });
  }
}