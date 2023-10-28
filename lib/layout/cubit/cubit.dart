
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce_app_project/layout/cubit/states.dart';
import 'package:e_comerce_app_project/model/product_model.dart';
import 'package:e_comerce_app_project/modules/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../../model/social_user_model.dart';
import '../../modules/products/products/add_product.dart';
import '../../modules/products/cart/cart.dart';
import '../../modules/products/products/home_product.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/local/cache_helper.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangePasswordVisibilityState());
  }


  bool isDark = true;
  void changeAppMode( { bool? fromShared}){
    if(fromShared != null)
    {
      isDark=fromShared;
      emit(AppChangeModeState());
    }
    else {
      isDark =!isDark;
      CacheHelper.sharedPreferences.setBool('isDark', isDark).then((value) {
        emit(AppChangeModeState());
      });
    }

  }


  SocialUserModel? userModel;
  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    if (kDebugMode)
    {
      print('here is uid $uId');
    }

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (kDebugMode)
      {
        print(value.data());
      }
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  PageController pageController=PageController(initialPage: 0);


  List<Widget> screens = [
     const HomeProducts(),
    const ProductScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Product',
    'Settings',
  ];

  void changeIndexBottomNav(int index) {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
  }


  File? profileImage;
  final ImagePicker picker = ImagePicker();
  Future<void> getProfileImage() async {
     await picker.pickImage(source: ImageSource.gallery).then((value)
    {
      profileImage = File(value!.path);
      emit(SocialProfileImagePickedSuccessState());
    });

  }

  File? coverImage;
  Future<void> getCoverImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value)
    {
      coverImage = File(value!.path);
      emit(SocialCoverImagePickedSuccessState());
    });

  }

  String profileImageUrl = '';
  void uploadProfileImage() {
    emit(SocialUpdateUserImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        if (kDebugMode) {
          print(value);
        }
        profileImageUrl = value;
        updateUserImage(image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    emit(SocialUpdateUserCoverLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        if (kDebugMode) {
          print(value);
        }
        coverImageUrl = value;
        updateUserCover(cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


  void updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) {
    SocialUserModel? model = SocialUserModel(
      phone: phone,
      name: name,
      image: userModel!.image,
      bio: userModel!.bio,
      cover: userModel!.cover,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      showToast(text: "Update Successful", state: ToastStates.SUCCESS);
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserName({
    required String name,
  }) {
    emit(SocialUpdateUserNameLoadingState());
    SocialUserModel? model = SocialUserModel(
      name: name,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
      phone:  userModel!.phone,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'name': name,
    }).then((value) {
      getUserData();
      showToast(text: "Update Successful", state: ToastStates.SUCCESS);
      emit(SocialUpdateUserNameSuccessState());
    }).catchError((error) {
      emit(SocialUpdateUserNameErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserBio({
    required String bio,
  }) {
    emit(SocialUpdateUserBioLoadingState());
    SocialUserModel? model = SocialUserModel(
      bio: bio,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
      name: userModel!.name,
      phone: userModel!.phone
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'bio': bio,
    }).then((value) {
      getUserData();
      showToast(text: "Update Successful", state: ToastStates.SUCCESS);
      emit(SocialUpdateUserBioSuccessState());
    }).catchError((error) {
      emit(SocialUpdateUserBioErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserPhone({
    required String phone,
  }) {
    emit(SocialUpdateUserPhoneLoadingState());
    SocialUserModel? model = SocialUserModel(
      phone: phone,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
       name: userModel!.name,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'phone': phone,
    }).then((value) {
      getUserData();
      emit(SocialUpdateUserPhoneSuccessState());
      showToast(text: "Update Successful", state: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(SocialUpdateUserPhoneErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserImage({
    required String image,
  }) {
    emit(SocialUpdateUserImageLoadingState());
    SocialUserModel? model = SocialUserModel(
      image: image,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
      name: userModel!.name,
      phone: userModel!.phone,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'image': image,
    }).then((value) {
      getUserData();
      showToast(text: "Update Successful", state: ToastStates.SUCCESS);
      emit(SocialUpdateUserImageSuccessState());
    }).catchError((error) {
      emit(SocialUpdateUserImageErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserCover({
    required String cover,
  }) {
    emit(SocialUpdateUserCoverLoadingState());
    SocialUserModel? model = SocialUserModel(
      image: cover,
      isEmailVerified: false,
      uId: userModel!.uId,
      email: userModel!.email,
      name: userModel!.name,
      phone: userModel!.phone,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'cover': cover,
    }).then((value) {
      getUserData();
      emit(SocialUpdateUserCoverSuccessState());
      showToast(text: "Update Successful", state: ToastStates.SUCCESS);
    }).catchError((error) {
      emit(SocialUpdateUserCoverErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }





  // Add data to Firebase



  void addProduct({required ProductModel productModel}) async {
    String productId = FirebaseFirestore.instance.collection('products').doc().id;
    String imageUrl = await uploadImage(productId, imageFile!);

    try {
      final newProduct = {
        'title': productModel.title,
        'price': productModel.price,
        'description': productModel.description,
        'category': productModel.category,
        'quantity': productModel.quantity,
        'image': imageUrl,
      };

      // Check if a product with the same title already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('title', isEqualTo: productModel.title)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // No duplicate product found, add the new product
        emit(ProductAddingLoading());
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .set(newProduct);

        emit(ProductAddingSuccess());
      } else {
        // Duplicate product found, handle accordingly
        emit(ProductAddingError('Product already exists.'));
      }
    } catch (e) {
      emit(ProductAddingError(e.toString()));
    }
  }


  File? imageFile;


  Future<String> uploadImage(String productId, File imageFile) async {
    try {
      // Create a reference to the image location in Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child(
          'product_images/$productId.jpg');

      // Upload the image file to Firebase Storage
      TaskSnapshot snapshot = await storageReference.putFile(imageFile);

      // Get the download URL of the uploaded image
      String imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }




  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {

      imageFile = File(pickedImage.path);
      emit(ProductImagePickedSuccessState());
    }
  }


  void getProducts() async {
    try {
      emit(ProductLoading());

        var products = await FirebaseFirestore.instance.collection('products').get() ;

      emit(ProductLoadedSuccess(products as List<ProductModel> ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }




  void searchProductsByName({required String nameProduct}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('title', isGreaterThanOrEqualTo: nameProduct)
          .get();

      final products = snapshot.docs.map((doc) {
        final data = doc.data();
        emit(SearchLoadingStates());

        return ProductModel(
          id: doc.id,
          title: data['title'],
          image: data['image'] ,
          category: data['category'],
          description: data['description'],
          price: data['price'].toDouble(),
          quantity: data['quantity'].toInt(),
        );
      }).toList();


      emit(SearchSuccessStates(products));
    } catch (error) {
      emit(SearchErrorStates());
    }
  }



  void updateProduct({
    required double price,
    required int quantity,
    required String title,
    required String id,
    required String category,
    required String description,
}) async {
    try {
      emit(UpdateLoadingStates());
      await FirebaseFirestore.instance
          .collection('products')
          .doc(id)
          .update({
        'title': title,
        // 'image': product.image,
        'category': category,
        'description': description,
        'price': price,
        'quantity': quantity,
      }).then((value)
      {
        showToast(
          state: ToastStates.SUCCESS,
          text: 'Update Product Successfully',
        );
        emit(UpdateSuccessStates());
      });

    } catch (e)
    {
      emit(UpdateErrorStates(error: e.toString()));
      showToast(
        state: ToastStates.ERROR,
        text: 'Error when update product ${e.toString()}',
      );
    }
  }




  void deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete().then((value)
      {
        showToast(
          state: ToastStates.SUCCESS,
          text: 'Delete Product Successfully',
        );
        emit(DeleteSuccessStates());
      });

    } catch (e) {
      showToast(
        state: ToastStates.ERROR,
        text: ' Error When Delete Product ${e.toString()}',
      );
      emit(DeleteErrorStates(error: e.toString()));
    }
  }



  void updateUserPassword({
    required String password,
  }) {

    emit(SocialUpdateUserPasswordLoadingState());
    FirebaseAuth.instance.
    currentUser?.updatePassword(password)
    .then((value) {
      showToast(
        state: ToastStates.SUCCESS,
        text: 'Update Successful',
      );
      emit(SocialUpdateUserPasswordSuccessState());
      getUserData();
    })
        .catchError((error){
      showToast(
        state: ToastStates.ERROR,
        text: 'process failed\nYou Should Re-login Before Change Password',
      );
      emit(SocialUpdateUserPasswordErrorState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });

  }



}
