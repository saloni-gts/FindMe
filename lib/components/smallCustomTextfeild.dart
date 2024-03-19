import 'package:flutter/material.dart';


import '../util/app_font.dart';
import '../util/color.dart';

class smallCustomTextfeild extends StatefulWidget {
  final TextEditingController? textController;
  final TextInputType? textInputType;

  const smallCustomTextfeild(
      {Key? key,
        this.textController,
        this.textInputType=TextInputType.text
      })
      : super(key: key);

  @override
  State<smallCustomTextfeild> createState() => _smallCustomTextfeildState();
}

class _smallCustomTextfeildState extends State<smallCustomTextfeild> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width*.50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            color: AppColor.textFieldGrey,
            border: Border.all(color: Colors.transparent)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: TextField(
            keyboardType:widget.textInputType,
            style: TextStyle(

              color: AppColor.textLightBlueBlack,
              fontFamily: AppFont.poppinsMedium,
              fontSize: 18.0,
            ),
            controller:widget.textController ,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
//
// class CustomTextFieldWithLeading extends StatefulWidget {
//
//   final TextEditingController? textController;
//   final bool isPassword;
//   final Function(String onChanged)? onChanged;
//
//
//
//   const CustomTextFieldWithLeading(
//       {Key? key,
//
//         this.textController,
//         this.isPassword = false,
//         this.onChanged
//       }) : super(key: key);
//
//   @override
//   State<CustomTextFieldWithLeading> createState() => _CustomTextFieldWithLeadingState();
// }
//
// class _CustomTextFieldWithLeadingState extends State<CustomTextFieldWithLeading> {
//   bool isShowPassowrd = false;
//   @override
//   void initState() {
//     isShowPassowrd = widget.isPassword;
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//
//
//         Container(
//           height: 50,
//           width: 335,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(28.0),
//               color: AppColor.textFieldGrey,
//               border: Border.all(color: Colors.transparent)
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left:18.0),
//             child: TextField(
//
//               onChanged: widget.onChanged,
//               obscureText: isShowPassowrd,
//               controller:widget.textController ,
//               style: TextStyle(
//                 color: AppColor.textLightBlueBlack,
//                 fontFamily: AppFont.poppinsMedium,
//                 fontSize: 18.0,
//               ),
//
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//
//         Positioned(
//           right: 10,
//           child: IconButton(onPressed: (){
//             isShowPassowrd = !isShowPassowrd;
//             setState(() {});
//           },
//               icon: Image.asset(isShowPassowrd
//                   ?  AppImage.closeeyeIcon
//                   : AppImage.eyeIcon
//
//               )),
//         )
//
//
//
//       ],
//     );
//   }
// }
//
//
//
//
