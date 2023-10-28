import 'package:e_comerce_app_project/model/product_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class SocialGetUserLoadingState extends AppStates {}

class SocialGetUserSuccessState extends AppStates {}

class SocialGetUserErrorState extends AppStates {
  String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends AppStates {}

class SocialGetAllUsersSuccessState extends AppStates {}

class SocialGetAllUsersErrorState extends AppStates {
  String error;
  SocialGetAllUsersErrorState(this.error);
}



class SocialChangeBottomNavState extends AppStates {}



class SocialCoverImagePickedSuccessState extends AppStates {}

class SocialCoverImagePickedErrorState extends AppStates {}

class SocialProfileImagePickedSuccessState extends AppStates {}

class SocialProfileImagePickedErrorState extends AppStates {}

class SocialUploadProfileImageSuccessState extends AppStates {}

class SocialUploadProfileImageErrorState extends AppStates {}

class SocialUploadCoverImageSuccessState extends AppStates {}

class SocialUploadCoverImageErrorState extends AppStates {}

class SocialUserUpdateLoadingState extends AppStates {}

class SocialUserUpdateErrorState extends AppStates {}

class SocialUpdateUserNameLoadingState extends AppStates {}

class SocialUpdateUserNameSuccessState extends AppStates {}

class SocialUpdateUserNameErrorState extends AppStates {}

class SocialUpdateUserBioLoadingState extends AppStates {}

class SocialUpdateUserBioSuccessState extends AppStates {}

class SocialUpdateUserBioErrorState extends AppStates {}

class SocialUpdateUserPhoneLoadingState extends AppStates {}

class SocialUpdateUserPhoneSuccessState extends AppStates {}

class SocialUpdateUserPhoneErrorState extends AppStates {}

class SocialUpdateUserImageLoadingState extends AppStates {}

class SocialUpdateUserImageSuccessState extends AppStates {}

class SocialUpdateUserImageErrorState extends AppStates {}

class SocialUpdateUserCoverLoadingState extends AppStates {}

class SocialUpdateUserCoverSuccessState extends AppStates {}

class SocialUpdateUserCoverErrorState extends AppStates {}

class SocialCreatePostLoadingState extends AppStates {}

class SocialCreatePostSuccessState extends AppStates {}

class SocialCreatePostErrorState extends AppStates {}

class SocialRemovePostImageState extends AppStates {}


class AppChangeModeState extends AppStates {}
class SocialChangePasswordVisibilityState extends AppStates {}




class SocialUpdateUserPasswordLoadingState extends AppStates {}

class SocialUpdateUserPasswordSuccessState extends AppStates {}

class SocialUpdateUserPasswordErrorState extends AppStates {
  String error;
  SocialUpdateUserPasswordErrorState(this.error);
}




class ProductImagePickedSuccessState extends AppStates {}


class ProductAddingLoading extends AppStates {}

class ProductAddingSuccess extends AppStates {}

class ProductAddingError extends AppStates {
  final String error;

  ProductAddingError(this.error);
}


class ProductInitial extends AppStates {}

class ProductLoading extends AppStates {}

class ProductLoadedSuccess extends AppStates {
  final List<ProductModel> products;

  ProductLoadedSuccess(this.products);
}

class ProductError extends AppStates {
  final String errorMessage;

  ProductError(this.errorMessage);
}







class SearchInitialState extends AppStates {}

class SearchLoadingStates extends AppStates {}

class SearchSuccessStates extends AppStates {
  final List<ProductModel> products;

  SearchSuccessStates(this.products);
}


class SearchErrorStates extends AppStates {}



class UpdateLoadingStates extends AppStates {}

class UpdateSuccessStates extends AppStates {}


class UpdateErrorStates extends AppStates {
  final String error;
  UpdateErrorStates({required this.error});
}




class DeleteSuccessStates extends AppStates {}


class DeleteErrorStates extends AppStates {
  final String error;
  DeleteErrorStates({required this.error});
}


