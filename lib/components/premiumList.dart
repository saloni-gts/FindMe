import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';


///        icon = 1 = cancel
///        icon = 2 = check

Widget PremiumList({required BuildContext context, required String txt1, int icon1 = 0, int icon2 = 0}) {
  // print("txt1::: $txt1");
  // print("icon2::: $icon2");
  return Padding(
    padding: const EdgeInsets.only(top: 8.0).copyWith(left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 220,
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: txt1,
                style: TextStyle(
                    color: AppColor.textLightBlueBlack,
                    // fontSize: 13,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ]),
          ),

          // Text(ls
          //   txt1,
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 2,
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //       fontSize: 13.0,
          //       color: AppColor.textLightBlueBlack,
          //       fontFamily: AppFont.poppinSemibold),
          // ),
        ),
        Container(
          margin: EdgeInsets.only(right: 30),
          // color: Colors.purpleAccent,

          child: Icon(
            icon2 == 2 ? Icons.cancel : Icons.check_circle,
            color: AppColor.textLightBlueBlack,
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.transparent,
          //         radius: 8,
          //         child: InkWell(
          //           onTap: () {},
          //           // child:
          //           // Icon(
          //           //   icon1==1?  Icons.cancel: Icons.check_circle,
          //           //   color: AppColor.textLightBlueBlack,)
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 20.0),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.transparent,
          //         radius: 8.5,
          //         child: Icon(
          //           icon2 == 2 ? Icons.cancel : Icons.check_circle,
          //           color: AppColor.textLightBlueBlack,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ],
    ),
  );
}
