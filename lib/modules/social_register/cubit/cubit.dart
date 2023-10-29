import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce_app_project/modules/social_register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/social_app/social_user_model.dart';
import '../../../shared/styles/icon_broken.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
      );
      //emit(SocialRegisterSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    SocialUserModel? model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      isEmailVerified: false,
      image:
      'https://image.freepik.com/free-photo/young-handsome-man-listens-music-with-earphones_176420-15616.jpg',
      bio: 'write your bio ...',
      cover:
      'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = IconBroken.Hide;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? IconBroken.Hide : IconBroken.Show;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
