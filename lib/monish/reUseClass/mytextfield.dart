import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';


import '../../util/app_font.dart';
import '../../util/color.dart';

class myCustomTextFeild extends StatefulWidget {
  final TextEditingController? textController;
  final TextInputType? textInputType;
  final String? hintText;
  bool isEnabled;
  final color;
  final height;
  final width;
  final fontsize;
  final icon1;
  final Function()? onTap;
  myCustomTextFeild(
      {Key? key,
        this.icon1,
        this.textController,
        this.height,
        this.fontsize,
        this.width,
        this.color,
        this.onTap,
        this.textInputType=TextInputType.text,
        this.hintText="",this.isEnabled=true,
      })
      : super(key: key);

  @override
  State<myCustomTextFeild> createState() => _myCustomTextFeildState();
}

class _myCustomTextFeildState extends State<myCustomTextFeild> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: widget.height,
        width: widget.width,
        // width: 335,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            color: AppColor.textFieldGrey,
            border: Border.all(color: Colors.transparent)
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(autofocus: false,
              enabled: widget.isEnabled,
              
              keyboardType:widget.textInputType,
              style: TextStyle(  
                
              color: AppColor.textLightBlueBlack,
              fontFamily: AppFont.poppinsMedium,
              fontSize: 18.0,
            ),
            controller:widget.textController ,
            decoration: InputDecoration(
              suffixIcon: widget.icon1,
        hintText: widget.hintText,
        hintStyle: TextStyle(
        color: widget.color,
        fontFamily: AppFont.poppinsMedium,
        fontSize: widget.fontsize,

        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
    ),
    ),
    );
  }
}
class CustomTextFieldWithLeading extends StatefulWidget {

  final TextEditingController? textController;
  final bool isPassword;
  final Function(String onChanged)? onChanged;
  final height;
  final width;

  const CustomTextFieldWithLeading(
  {Key? key,
  this.width,
  this.height,
  this.textController,
  this.isPassword = false,
  this.onChanged
  }) : super(key: key);

  @override
  State<CustomTextFieldWithLeading> createState() => _CustomTextFieldWithLeadingState();
}

class _CustomTextFieldWithLeadingState extends State<CustomTextFieldWithLeading> {
  bool isShowPassowrd = false;
  @override
  void initState() {
    isShowPassowrd = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

    Container(
    height:widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          color: AppColor.textFieldGrey,
          border: Border.all(color: Colors.transparent)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:18.0),
        child: TextField(

        onChanged: widget.onChanged,
        obscureText: isShowPassowrd,
        controller:widget.textController ,
        style: TextStyle(
        color: AppColor.textLightBlueBlack,
        fontFamily: AppFont.poppinsMedium,
        fontSize: 18.0,
        ),

        decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
    ),
    ),

    Positioned(
    right: 10,
    child: IconButton(onPressed: (){
    isShowPassowrd = !isShowPassowrd;
    setState(() {});
    },
    icon: Image.asset(isShowPassowrd
    ?  AppImage.closeeyeIcon
        : AppImage.eyeIcon

    )),
    )

    ],
    );
  }
}
