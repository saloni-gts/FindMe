import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';

import '../util/app_images.dart';

class customAppbar extends StatelessWidget implements PreferredSizeWidget {
  bool isbackbutton;
  String titlename;
  bool isEditIcon;
  VoidCallback? tap2;
  VoidCallback? customBack;

  customAppbar(
      {Key? key, this.isbackbutton = true, this.titlename = "", this.isEditIcon = false, this.customBack, this.tap2})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(55);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Container(
                height: 12,
                width: double.infinity,
                color: const Color(0xffCBC4A9),
                // width: MediaQuery.of(context).size.width,
                // child: Image.asset(
                //   AppImage.topBorder,
                //   fit: BoxFit.cover,
                // ),
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //   image: AssetImage(
                //     AppImage.topBorder,
                //   ),
                //   fit: BoxFit.cover,
                // )),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isbackbutton
                    ? Expanded(
                        flex: 1,
                        child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                              child: SizedBox(
                                height: 16,
                                width: 20,
                                child: Image.asset(
                                  AppImage.backArrow,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              if (customBack == null) {
                                Navigator.pop(context);
                              } else {
                                customBack!();
                              }
                            }),
                      )
                    : const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 8,
                  child: Text(
                    titlename,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.newBlueGrey,
                      fontFamily: AppFont.poppinsMedium,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                isEditIcon
                    ? Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: InkWell(onTap: tap2, child: Image.asset(AppImage.editLineIcon)),
                      )
                    : const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
