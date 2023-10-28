

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();


    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {


        var formKey = GlobalKey<FormState>();
        return  ConditionalBuilder(
            condition:  state is !SocialUpdateUserPasswordSuccessState,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Edit Password'),
                  actions: const [
                    Icon(
                      IconBroken.Edit_Square,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(0),
                            child: Image.network('https://i.ibb.co/TP1zcPq/2-03.png',scale: 4),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'E-mail',),
                            ),
                          ),

                      Container(
                        height: 70,width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Forgot Password',style: TextStyle(fontSize: 20),),
                          onPressed: () async{
                            try{
                              assert(emailController.text.contains(RegExp(r'\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6}')));
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: emailController.text)
                                  .then((value) => showToast(state: ToastStates.SUCCESS,text:  'Done Send'))
                                  .catchError((error) => error.toString());
                            }catch(e){
                              showToast(state: ToastStates.ERROR,text: 'this no\'t E-Mail');
                            }
                          },
                        )

                      )
                        ],
                      ),
                    ),
                  ),
                ),

              );
            },
            fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );


      },
    );




  }
}
