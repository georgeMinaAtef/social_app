//import 'package:udemy_first_app/modules/login/login_screen.dart.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../networks/local/cache_helper.dart';
import '../styles/icon_broken.dart';
import 'constants.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget defaultTextButton({
  required String text,
  required Function function,
}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Text(text.toUpperCase()));

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required String text,
  required Function function,
  bool isUpperCase = true,
  double radius = 0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        /*()
        {
          function();
          }*/
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

//----------------------------- defaultFormField -------------------------------
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  onSubmit,
  onChange,
  onTap,
  required validator,
  function,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: function,
        )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
// --------------------------------- defaultTextFormField -------------------------


Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String label,
  String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    TextFormField(
      focusNode: FocusNode(),
      style: const TextStyle(),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autofocus: false,

      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: Colors.grey,
          ),
        )
            : null,
        filled: true,
        isCollapsed: false,
        fillColor: Colors.deepOrange.withOpacity(0.2),
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        focusColor: Colors.white,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );



// --------------------------------- designedFormField -------------------------
Widget designedFormField
  ({
  fontColor,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  String? label,
   String? hint,
  IconData? prefixIcon,
  IconData? suffixIcon,
  onSubmit,
  onChange,
  onTap,
  required validator,
  function,
}) =>
    TextFormField(
      style: TextStyle(
        color: fontColor ?? Colors.black,
      ),
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: fontColor ?? Colors.black,
        ),
        labelStyle: TextStyle(
          color: fontColor ?? Colors.black,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: fontColor ?? Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.orange,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: fontColor ?? Colors.black,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(
            suffixIcon,
            color: fontColor ?? Colors.black,
          ),
          onPressed: function,
        )
            : null,
      ),
    );


// -------------------------- buildTaskItem ------------------------------------
Widget buildTaskItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: (Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      )),
    );

// Widget buildArticleItem(article, context) => InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => WebViewScreen(article['url'])),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

// --------------------------- myDivider ---------------------------------------
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

// ---------------------------- fullDivider ------------------------------------
Widget fullDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

// Widget articleBuilder(list, context, {isSearch = false}) => Conditional.single(
//       context: context,
//       conditionBuilder: (BuildContext context) => list.length > 0,
//       widgetBuilder: (BuildContext context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: 10,
//       ),
//       fallbackBuilder: (BuildContext context) =>
//           isSearch ? Container() : Center(child: CircularProgressIndicator()),
//     );


// ------------------------------ show toast -----------------------------------
void showToast({
  String? text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// Widget buildListProduct(model, BuildContext context) => Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         height: 120,
//         child: Row(
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: [
//                 Image(
//                   image: NetworkImage('${model.image}'),
//                   width: 120,
//                   height: 120,
//                   fit: BoxFit.cover,
//                 ),
//                 if (model.discount != 0)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 5),
//                     color: Colors.red,
//                     child: Text(
//                       'DISCOUNT',
//                       style: TextStyle(
//                         fontSize: 8,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${model.name}',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       height: 1.3,
//                       fontSize: 14,
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Text(
//                         '${model.price.round()}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: defaultColor,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       if (model.discount != 0)
//                         Text(
//                           '${model.oldPrice.round()}',
//                           style: TextStyle(
//                             decoration: TextDecoration.lineThrough,
//                             fontSize: 10,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context)
//                               .changeFavorites(productId: model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor:
//                               ShopCubit.get(context).favorites[model.id]!
//                                   ? defaultColor
//                                   : Colors.grey,
//                           child: Icon(
//                             Icons.favorite_border,
//                             size: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

// ----------------------------- SIgnOut  --------------------------------------
void signOut(context,loginScreen){
  navigateAndFinish(context, loginScreen);
  showToast(text: "Logout", state: ToastStates.SUCCESS);
  CacheHelper.removeData(key: 'uId');
uId =   null;
}





// ------------------ defaultAppBar -------------------------------------------
AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(
        title!,
      ),
      titleSpacing: 5,
      actions: actions,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
    );