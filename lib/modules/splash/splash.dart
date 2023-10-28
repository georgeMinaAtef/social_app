
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../social_login/social_login_screen.dart';
import 'cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {



    return BlocBuilder<SplashCubit, bool>(
      builder: (context, state) {
        if (state) {
          // Data loaded, navigate to the home screen or any other screen
          Widget startWidget;
          bool? onBoarding = CacheHelper.getData(key: 'onBoarding');


          if (onBoarding == null)
          {
            if (uId != null)
            {
              startWidget = const Layout();
            }
            else
            {
              startWidget = const SocialLoginScreen();
            }
          }
          else
          {
            startWidget = const SocialLoginScreen();
          }

          return startWidget;
        }
        else
        {
          // Show a loading indicator or any other splash screen UI
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit:BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}