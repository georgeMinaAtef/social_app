

import 'package:e_comerce_app_project/modules/products/cart/cubit.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import 'package:e_comerce_app_project/shared/bloc_observer.dart';
import 'package:e_comerce_app_project/shared/components/constants.dart';
import 'package:e_comerce_app_project/shared/networks/local/cache_helper.dart';
import 'package:e_comerce_app_project/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';
import 'modules/social_login/cubit/cubit.dart';
import 'modules/social_register/cubit/cubit.dart';
import 'modules/splash/cubit.dart';
import 'modules/splash/splash.dart';


// flutter build appbundle --build-name=1.2.0+1 --build-number=2

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();


  uId = CacheHelper.getData(key: 'uId');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp( MyApp(
    isDark:isDark,
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp(
      {
        Key? key,
        this.isDark,
      }
      ) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => SocialLoginCubit()),
        BlocProvider(create: (context) => SocialRegisterCubit()),
        BlocProvider( create: (context) => SplashCubit()..loadData(), child: const SplashScreen(),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit=AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark?ThemeMode.dark:ThemeMode.light,
            home:  const SplashScreen(),
          );
        },
      ),
    );

  }
}


