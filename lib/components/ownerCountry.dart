
import 'package:country_picker/country_picker.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/usermodel.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';

class CntrePikrOwner extends StatefulWidget {
  final TextEditingController? phoneNumController;
  String countryCode;
  String countryFlag;
   CntrePikrOwner({Key? key, this.phoneNumController,this.countryCode="",this.countryFlag=""
}) : super(key: key);

@override
State<CntrePikrOwner> createState() => _CntrePikrOwnerState();
}
UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;

class _CntrePikrOwnerState extends State<CntrePikrOwner> {
  String CountryCode = "GB";
  String PhoneCode = "44";
  String flag = "🇬🇧";
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,authProvider,child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColor.textFieldGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [

              InkWell(
                onTap: (){
                  showCountryPicker(
                      searchAutofocus: false,
                      context: context,
                      onSelect: (Country cntry){
                    print("=====countryCode owner=====${cntry.countryCode}");
                    print("=====phoneCode owner=${cntry.phoneCode}");
                    print(cntry.flagEmoji);
                    CountryCode = cntry.countryCode.toString();
                    PhoneCode = cntry.phoneCode.toString();
                    flag = cntry.flagEmoji.toString();


                    widget.countryCode=cntry.phoneCode.toString();
                    widget.countryFlag=cntry.flagEmoji.toString();

                    print("widget.countryFlag===${widget.countryFlag}");

                    setState(() {
                      authProvider.setMobile(cntry.phoneCode);

                      authProvider.setUsrCode(cntry.phoneCode);

                      widget.countryCode=cntry.phoneCode.toString();
                      widget.countryFlag=cntry.flagEmoji.toString();


                    });
                  });
                },
                child: Container(
                  height: 45,
                  width: 125,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(  widget.countryFlag,
                            style: TextStyle(fontSize: 20.0)
                        ),
                      ),

                      VerticalDivider(
                        color: AppColor.textLightBlueBlack,
                        thickness: 2,
                        width: 2,
                      ),
                      SizedBox(
                        width: 2,
                      ),

                      InkWell(
                        onTap: () {},
                        child:

                        Text(
                          "("+"${widget.countryCode}"+")",

                            style: TextStyle(
                                color: AppColor.textLightBlueBlack,
                                fontFamily: AppFont.poppinsMedium,
                                fontSize: 18.0)),
                      )




                    ],
                  ),

                ),

              ),

              Expanded(
                  flex: 7,
                  child: TextField(
                    onTap: (){

                    },
                    autofocus: false,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: AppColor.textLightBlueBlack,
                      fontFamily: AppFont.poppinsMedium,
                      fontSize: 18.0,
                    ),
                    controller: widget.phoneNumController,
                    maxLength: 16,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        counterText: "",
                        enabled: true,
                        counterStyle: TextStyle(fontSize: 50),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.transparent)),
                        fillColor: AppColor.textFieldGrey,
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.transparent))),
                  ))

            ],

          ),

        );
      }
    );







    // return Stack(
    //   children: [
    //     Container(
    //       height: 50,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(28.0),
    //           color: AppColor.textFieldGrey,
    //           border: Border.all(color: Colors.transparent)
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.only(left:98.0),
    //         child: TextField(
    //           keyboardType:TextInputType.phone,
    //           style: TextStyle(
    //
    //             color: AppColor.textLightBlueBlack,
    //             fontFamily: AppFont.poppinsMedium,
    //             fontSize: 18.0,
    //           ),
    //           controller:widget.phoneNumController,
    //           decoration: InputDecoration(
    //             border: InputBorder.none,
    //             focusedBorder: InputBorder.none,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top:7,
    //       child: GestureDetector(
    //         onTap: (){
    //           showCountryPicker(context: context,
    //               onSelect: (Country cntry) {
    //                 AuthProvider auth = Provider.of(context,listen: false);
    //                 //  auth.setCountry(cntry.countryCode,cntry.phoneCode,cntry.flagEmoji);
    //
    //
    //
    //
    //                 print("=====countryCode owner=====${cntry.countryCode}");
    //                 print("=====phoneCode owner=${cntry.phoneCode}");
    //                 print(cntry.flagEmoji);
    //                 CountryCode = cntry.countryCode.toString();
    //                 PhoneCode = cntry.phoneCode.toString();
    //                 flag = cntry.flagEmoji.toString();
    //
    //
    //                 widget.countryCode=cntry.phoneCode.toString();
    //                 widget.countryFlag=cntry.flagEmoji.toString();
    //
    //                 setState(() {
    //                   auth.setMobile(cntry.phoneCode);
    //
    //
    //                 });
    //               });
    //
    //         },
    //         child: Container(
    //           height: 40,
    //           width: 100,
    //           decoration: BoxDecoration(
    //               border: Border.all(color: Colors.transparent)
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                 child: Text(
    //                     widget.countryFlag,
    //
    //                     style: TextStyle(fontSize: 20.0)),
    //               ),
    //
    //               VerticalDivider(
    //                 color: AppColor.textLightBlueBlack,
    //                 thickness: 2, width:2,
    //               ),
    //               SizedBox(
    //                 width: 2,
    //               ),
    //
    //               InkWell(
    //                 onTap: () {
    //
    //                 },
    //                 child:
    //                 Text("(${widget.countryCode})",
    //             //    Text("(${PhoneCode})",
    //                     style: TextStyle(
    //                     color: AppColor.textLightBlueBlack,
    //                     fontFamily: AppFont.poppinsMedium,
    //                     fontSize: 18.0)),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //
    //   ],
    // );


  }
}