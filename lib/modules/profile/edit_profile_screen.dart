
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_comerce_app_project/layout/cubit/cubit.dart';
import 'package:e_comerce_app_project/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = AppCubit.get(context).userModel;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit=AppCubit.get(context);
        var color= cubit.isDark?  Colors.white:Colors.black;

        File? profileImage = AppCubit.get(context).profileImage;
        File? coverImage = AppCubit.get(context).coverImage;
        ImageProvider backG;
        ImageProvider backGCover;
        if (profileImage == null)
        {
          backG = NetworkImage('${userModel!.image}');
        } else {
          backG = FileImage(profileImage);
        }
        if (coverImage == null) {
          backGCover = NetworkImage('${userModel!.cover}');
        } else {
          backGCover = FileImage(coverImage);
        }

        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 14,
                    ),
                  SizedBox(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: backGCover,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).getCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: backG,
                                // profileImage == null
                                //     ? null /*NetworkImage('${userModel.image}')*/
                                //     : FileImage(profileImage),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 16,
                                child: IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (AppCubit.get(context).profileImage != null ||
                      AppCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (AppCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    AppCubit.get(context)
                                        .uploadProfileImage();
                                  },
                                  text: 'upload profile',
                                ),
                                if (state is SocialUpdateUserImageLoadingState)
                                  const LinearProgressIndicator(),
                                if (state is SocialUpdateUserImageLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (AppCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    AppCubit.get(context).uploadCoverImage();
                                  },
                                  text: 'upload cover',
                                ),
                                if (state is SocialUpdateUserCoverLoadingState)
                                  const LinearProgressIndicator(),
                                if (state is SocialUpdateUserCoverLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (AppCubit.get(context).profileImage != null ||
                      AppCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: designedFormField(
                          fontColor: color,
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: IconBroken.User,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ConditionalBuilder(
                          condition:  state is SocialUpdateUserNameLoadingState,
                          builder: (BuildContext context) =>
                          const CircularProgressIndicator(),
                          fallback: (BuildContext context) => TextButton(
                            onPressed: () {
                              AppCubit.get(context)
                                  .updateUserName(name: nameController.text);
                            },
                            child: const Text('Edit Name '),
                          ),
                      ),


                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: designedFormField(
                          fontColor: color,
                          controller: bioController,
                          type: TextInputType.text,
                          label: 'Bio',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Bio must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: IconBroken.Info_Circle,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ConditionalBuilder(
                          condition:  state is SocialUpdateUserBioLoadingState,
                          builder: (BuildContext context) =>
                          const CircularProgressIndicator(),
                          fallback: (BuildContext context) => TextButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .updateUserBio(bio: bioController.text);
                              },
                              child: const Text('Edit Bio      ')),
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: designedFormField(
                          fontColor: color,
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: Icons.phone_iphone_outlined,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ConditionalBuilder(
                          condition: state is SocialUpdateUserPhoneLoadingState,
                          builder: (BuildContext context) =>
                          const CircularProgressIndicator(),
                          fallback:  (BuildContext context) => TextButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .updateUserPhone(phone: phoneController.text);
                              },
                              child: const Text('Edit Phone')),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
