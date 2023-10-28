import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../edit_password/edit_password_screen.dart';
import '../profile/edit_profile_screen.dart';
import '../social_login/social_login_screen.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        var color=cubit.isDark?Colors.white:Colors.black;
        return  Scaffold(

          body: SingleChildScrollView(
            child: Column(

              children: [

                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.network(
                    'https://i.ibb.co/TP1zcPq/2-03.png',
                    fit:BoxFit.fill,
                  ),
                ),


                InkWell(
                  onTap: () {
                    navigateTo(context,  const EditProfileScreen());                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: Row(
                        children:  [
                          Icon(
                            IconBroken.Edit,
                            color: color,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20,
                              color: cubit.isDark?Colors.white:Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Icon(IconBroken.Arrow___Right_2,
                            color: cubit.isDark?Colors.white:Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                fullDivider(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const EditPasswordScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: Row(
                        children:  [
                          Icon(
                            IconBroken.Unlock,
                            color: cubit.isDark?Colors.white:Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: cubit.isDark?Colors.white:Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Icon(IconBroken.Arrow___Right_2,
                            color: cubit.isDark?Colors.white:Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                fullDivider(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    cubit.changeAppMode();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:  [
                          ConditionalBuilder(
                              condition: cubit.isDark,
                              builder: (BuildContext context) => Icon(
                                Icons.light_mode_outlined,
                                color: cubit.isDark?Colors.white:Colors.black,
                              ),
                              fallback: (BuildContext context) => Icon(
                                Icons.dark_mode_outlined,
                                color: cubit.isDark?Colors.white:Colors.black,
                              ),
                          ),


                          const SizedBox(
                            width: 5,
                          ),


                          ConditionalBuilder(
                              condition: cubit.isDark,
                              builder: (BuildContext context) => Text(
                                'Light Mode ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: cubit.isDark?Colors.white:Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              fallback: (BuildContext context) => Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: cubit.isDark?Colors.white:Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ),




                          const Spacer(),
                          const SizedBox(width: 10,),
                          Icon(IconBroken.Arrow___Right_2,
                            color: cubit.isDark?Colors.white:Colors.black,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                fullDivider(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child:InkWell(
                    onTap: () {
                      navigateAndFinish(context, const SocialLoginScreen());
                      uId = '';
                      showToast(text: "Logout", state: ToastStates.ERROR);
                      CacheHelper.removeData(key: 'uId');
                      cubit.currentIndex=0;
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children:  [
                            Icon(IconBroken.Logout,
                              color: color,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'LOGOUT',
                              style: TextStyle(
                                color: color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(IconBroken.Arrow___Right_2,
                              color: color,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ),
                fullDivider(),

              ],
            ),
          ),
        );
      },
    );

  }
}
