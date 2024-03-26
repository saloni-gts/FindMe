import 'package:flutter/material.dart';

import '../util/app_font.dart';


class CustomCurvedAppbar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool isTitleCenter;
  final bool showEndText;
  Widget icn;
  final String endText;
  final bool showIcon;
  final bool isRedColor;
  final bool showBackIcon;
  VoidCallback? onTap1;
  // bool is
  CustomCurvedAppbar(
      {super.key,
      this.title = "",
      this.isTitleCenter = false,
      this.endText = "",
      this.icn =const SizedBox(),
      this.showEndText = false,
      this.showIcon = false,
      this.showBackIcon = true,
      this.isRedColor = false,
      this.onTap1});

  @override
  Widget build(BuildContext context) {
    print("appbar text===>>>$title");

    return AppBar(
      centerTitle: isTitleCenter,
      titleSpacing: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: isRedColor ? Color(0xffB83446) : Color(0xffB83446),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(22.0),
      )),
      title: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.0), bottomLeft: Radius.circular(12.0)),
          color: Color(0xffB83446),
        ),
        child: Row(children: [
          showBackIcon
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ))
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.abc,
                    color: Color(0xffB83446),
                  )),
          // 8.ww,
          SizedBox(
            width: MediaQuery.of(context).size.width * .75,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: isTitleCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: AppFont.poppinsBold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          showEndText
              ? InkWell(
                  onTap: onTap1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text(
                      endText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: AppFont.poppinsBold,
                      ),
                    ),
                  ),
                )
              : showIcon
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child:icn ,
                    )
                  : const SizedBox(),
          
             SizedBox(
              width: 6,
             )
        ]),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(62);
}
