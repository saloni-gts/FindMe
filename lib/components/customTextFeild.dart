import 'package:find_me/util/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../util/app_font.dart';
import '../util/color.dart';

class CustomTextFeild extends StatefulWidget {
  final TextEditingController? textController;
  final TextInputType? textInputType;
  final String? hintText;
  // final VoidCallback? onTap1;

  bool isEnabled;

  CustomTextFeild(
      {Key? key,
      this.textController,
      this.textInputType = TextInputType.text,
      this.hintText = "",
      // this.onTap1=(){},
      this.isEnabled = true})
      : super(key: key);

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: TextField(
        maxLines: 1,
        onTap: () {},
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autofocus: false,
        // scrollPadding: EdgeInsets.all(20.0),
        enabled: widget.isEnabled,
        keyboardType: widget.textInputType,
        showCursor: widget.textInputType == TextInputType.none ? false : true,
        style: const TextStyle(
          color: AppColor.textLightBlueBlack,
          fontFamily: AppFont.poppinsMedium,
          fontSize: 18.0,
        ),
        controller: widget.textController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.transparent)),
          fillColor: AppColor.textFieldGrey,
          filled: true,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xffCCCCCC))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xffCCCCCC))),
          hintStyle: const TextStyle(
            color: AppColor.textGreyColor,
            fontFamily: AppFont.poppinsMedium,
            fontSize: 15.0,
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

  const CustomTextFieldWithLeading({Key? key, this.textController, this.isPassword = false, this.onChanged})
      : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: TextField(
        maxLines: 1,
        obscureText: isShowPassowrd,
        onChanged: widget.onChanged,

        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autofocus: false,
        // scrollPadding: EdgeInsets.all(20.0),
        // enabled: widget.isEnabled,
        // keyboardType: widget.textInputType,
        style: const TextStyle(
          color: AppColor.textLightBlueBlack,
          fontFamily: AppFont.poppinsMedium,
          fontSize: 18.0,
        ),
        controller: widget.textController,

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColor.newTextFeildGrey)),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColor.newTextFeildGrey)),
          filled: true,
          fillColor: AppColor.textFieldGrey,

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColor.newTextFeildGrey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColor.newTextFeildGrey)),
          suffixIcon: IconButton(
              onPressed: () {
                isShowPassowrd = !isShowPassowrd;
                setState(() {});
              },
              icon: Image.asset(isShowPassowrd ? AppImage.closeeyeIcon : AppImage.eyeIcon)),

          // border: InputBorder.none,
          // focusedBorder: InputBorder.none,
        ),

        // decoration: InputDecoration(
        //   contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //   // hintText: widget.hintText,
        //   border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(20),
        //       borderSide: BorderSide(color: Colors.transparent)),
        //   focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(20),
        //       borderSide: BorderSide(color: Colors.transparent)),
        //   fillColor: AppColor.textFieldGrey,
        //   filled: true,
        //   disabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(20),
        //       borderSide: BorderSide(color: Colors.transparent)),
        //   enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(20),
        //       borderSide: BorderSide(color: Colors.transparent)),
        //   hintStyle: TextStyle(
        //     color: AppColor.textGreyColor,
        //     fontFamily: AppFont.poppinsMedium,
        //     fontSize: 15.0,
        //   ),
        // ),
      ),
    );
  }
}
