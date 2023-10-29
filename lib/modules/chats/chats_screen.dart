
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/social_app/social_user_model.dart';
import '../../shared/components/components.dart';
import '../chat_details/ChatDetailsScreen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        var color = cubit.isDark ? Colors.white : Colors.black;
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder:(BuildContext context) =>  ListView.separated(
              itemBuilder:(context, index) => buildChatItem(SocialCubit.get(context).users[index],context,color),
              separatorBuilder:(context, index) =>  Divider(color: color),
              itemCount: SocialCubit.get(context).users.length ,
            ),
            fallback: (BuildContext context) => const Center(child:CircularProgressIndicator()
        ),
        );
      },
    ) ;
  }
  Widget buildChatItem(SocialUserModel model,context,color)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}'
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style:  TextStyle(
              color: color,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
