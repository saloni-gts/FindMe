import 'package:find_me/util/app_font.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';

import '../../components/globalnavigatorkey.dart';
import '../../util/app_images.dart';
import '../../util/app_route.dart';

class MycustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final isbackbutton;
  String titlename;
  final fontsize;
  final icon;

  final seticon;
  VoidCallback? customBack;
  VoidCallback tap2;
  MycustomAppbar(
      {Key? key,
      this.seticon,
      this.isbackbutton = true,
      this.icon = true,
      required this.tap2,
      this.fontsize,
      this.customBack,
      this.titlename = ""})
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5.0),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     child:
          //      Image.asset(
          //       AppImage.topBorder,
          //       fit: BoxFit.cover,
          //     ),
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //       image: AssetImage(
          //         AppImage.topBorder,
          //       ),
          //       fit: BoxFit.cover,
          //     )),
          //   ),
          // ),

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
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 4),
              child: Row(
                children: [
                  isbackbutton
                      ? InkWell(
                          child: SizedBox(
                            height: 16,
                            width: 22,
                            child: Image.asset(
                              AppImage.backArrow,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            if (customBack == null) {
                              Navigator.pop(context);
                            } else {
                              customBack!();
                            }
                          })
                      : const Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    flex: 24,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Center(
                        child: Text(
                          titlename,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColor.textLightBlueBlack,
                            fontFamily: AppFont.poppinsMedium,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: 120,
                    ),
                  ),
                  icon
                      ? InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Image.asset(
                              seticon,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            tap2();
                          },
                        )
                      : const Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 0,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
