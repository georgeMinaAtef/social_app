import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_comerce_app_project/modules/edit_password/edit_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';
import '../../layout/cubit/cubit.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              navigateAndFinish(context, const Layout());
              AppCubit.get(context).getUserData();
            });
          }
        },
        builder: (BuildContext context, state) {
          var cubit=SocialLoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children:  [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.network(
                      'https://i.ibb.co/TP1zcPq/2-03.png',
                      fit:BoxFit.fill,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            designedFormField(
                              fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: "Email address",
                              validator: (value){
                                if(value.isEmpty)
                                {
                                  return "Email must not be empty";
                                }

                              },
                              prefixIcon: IconBroken.Add_User,

                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            designedFormField(
                              fontColor:AppCubit.get(context).isDark?Colors.white:Colors.black,

                              function: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              label: "Password",
                              validator: (value){
                                if(value.isEmpty)
                                {
                                  return "Password must not be empty";
                                }
                              },
                              prefixIcon: IconBroken.Unlock,
                              isPassword: cubit.isPassword,
                              suffixIcon: cubit.suffix,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                                condition: state is! SocialLoginLoadingState,
                                builder: (BuildContext context) =>
                                    defaultButton(
                                      text: 'Login',
                                      function:(){
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(email: emailController.text,password:  passwordController.text);
                                        }
                                      },
                                      background: Colors.blue,
                                      radius: 6,
                                    ),
                                fallback: (BuildContext context) =>
                                const Center(child: CircularProgressIndicator()),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(onPressed: ()
                            {
                              navigateTo(context, const EditPasswordScreen());
                            }, child: const Text(
                              'Forgotten Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.5,
                              ),
                            )),
                            const SizedBox(
                              height: 25,
                            ),
                            myDivider(),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultButton(
                              text: "Create New Account",
                              function: (){
                                navigateTo(context, const SocialRegisterScreen());
                              },
                              radius: 6,
                              background: Colors.deepOrange,
                              width: 250,
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
