import 'package:country_picker/country_picker.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/usermodel.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';
String? str;
class CntrePikrProfilepage extends StatefulWidget {
  final TextEditingController? phoneNumController;
  String countryCode;
  String countryFlag;

  CntrePikrProfilepage({Key? key, this.phoneNumController,
    this.countryCode="",this.countryFlag=""
  }) : super(key: key);

  @override
  State<CntrePikrProfilepage> createState() => _CntrePikrProfilepageState();
}



class _CntrePikrProfilepageState extends State<CntrePikrProfilepage> {

  //var setPhCode=widget.phNumCode;
  String CountryCode = "GB";
  String PhoneCode = "44";
  String flag = "🇬🇧";



  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;
  void initState(){

    AuthProvider authProvider =Provider.of(context,listen: false);
    // if(authProvider.cntryflag!.isEmpty){
    //   authProvider.cntryflag="";
    // }
    //
    if(user.phoneCode!.isEmpty){
      user.phoneCode="44";
    }

    // PhoneCode=widget.phNumCode??"";
    // flag=widget.flagIcon??"";

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.textFieldGrey,
          borderRadius:BorderRadius.circular(20),
        ),

        child: Row(
          children: [

            InkWell(

              onTap: (){
                showCountryPicker(
                    context: context,
                    onSelect: (Country cntry) {
                      AuthProvider auth = Provider.of(context, listen: false);
                      //  auth.setCountry(cntry.countryCode,cntry.phoneCode,cntry.flagEmoji);
                      print("flag selection==== ${cntry.flagEmoji}");
                      HiveHandler.updatePhoneCode(cntry.phoneCode.toString());

                      auth.setCountry(
                          cntry.countryCode,
                          cntry.phoneCode,
                          cntry.flagEmoji
                      );

                      print("=====countryCode=====${cntry.countryCode}");
                      print("=====phoneCode=${cntry.phoneCode}");
                      print(cntry.flagEmoji);
                      CountryCode = cntry.countryCode.toString();
                      PhoneCode = cntry.phoneCode.toString();
                      flag = cntry.flagEmoji.toString();
                      setState(() {

                        AuthProvider authProvider=Provider.of(context,listen: false);
                        PhoneCode = user.phoneCode.toString();
                        // PhoneCode = cntry.phoneCode.toString();
                        flag = cntry.flagEmoji.toString();
                        str=cntry.flagEmoji.toString();
                        // authProvider.onrFlag=cntry.flagEmoji;

                      });
                    });


              },
              child: Consumer<AuthProvider>(
                builder: (context,authProvider,child) {
                  return Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(authProvider.onrFlag??"",
                              style: TextStyle(fontSize: 20.0)),
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
                          child: Text("(${user.phoneCode})",
                              style: TextStyle(
                                  color: AppColor.textLightBlueBlack,
                                  fontFamily: AppFont.poppinsMedium,
                                  fontSize: 18.0)),
                        )

                      ],
                    ),
                  );
                }
              ),


            ),
            Expanded(
                flex: 7
                ,child:   TextField(
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



    //
    //   TextField(
    //   maxLines: 1,
    //   keyboardType: TextInputType.phone,
    //   style: TextStyle(
    //     color: AppColor.textLightBlueBlack,
    //     fontFamily: AppFont.poppinsMedium,
    //     fontSize: 18.0,
    //   ),
    //   controller: widget.phoneNumController,
    //   maxLength: 16,
    //   decoration: InputDecoration(
    //       contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //       prefix: GestureDetector(
    //         onTap: () {
    //           showCountryPicker(
    //               context: context,
    //               onSelect: (Country cntry) {
    //                 AuthProvider auth = Provider.of(context, listen: false);
    //                 //  auth.setCountry(cntry.countryCode,cntry.phoneCode,cntry.flagEmoji);
    //                 print("flag selection==== ${cntry.flagEmoji}");
    //                 HiveHandler.updatePhoneCode(cntry.phoneCode.toString());
    //
    //                 auth.setCountry(
    //                     cntry.countryCode,
    //                     cntry.phoneCode,
    //                     cntry.flagEmoji
    //                 );
    //
    //                 print("=====countryCode=====${cntry.countryCode}");
    //                 print("=====phoneCode=${cntry.phoneCode}");
    //                 print(cntry.flagEmoji);
    //                 CountryCode = cntry.countryCode.toString();
    //                 PhoneCode = cntry.phoneCode.toString();
    //                 flag = cntry.flagEmoji.toString();
    //                 setState(() {
    //                   PhoneCode = user.phoneCode.toString();
    //                   // PhoneCode = cntry.phoneCode.toString();
    //                   flag = cntry.flagEmoji.toString();
    //                   str=cntry.flagEmoji.toString();
    //
    //                 });
    //               });
    //         },
    //         child: Consumer<AuthProvider>(
    //           builder: (context,authProvider,child) {
    //             return Container(
    //
    //               height: 40,
    //               width: 126,
    //               decoration: BoxDecoration(
    //                 // color: Colors.blue,
    //                   border: Border.all(color: Colors.transparent)
    //
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                     child: Text(authProvider.cntryflag??"",
    //                         style: TextStyle(fontSize: 20.0)),
    //                   ),
    //                   VerticalDivider(
    //                     color: AppColor.textLightBlueBlack,
    //                     thickness: 2,
    //                     width: 2,
    //                   ),
    //                   SizedBox(
    //                     width: 2,
    //                   ),
    //                   InkWell(
    //                     onTap: () {},
    //                     child: Text("(${user.phoneCode})",
    //                         style: TextStyle(
    //                             color: AppColor.textLightBlueBlack,
    //                             fontFamily: AppFont.poppinsMedium,
    //                             fontSize: 18.0)),
    //                   )
    //                 ],
    //               ),
    //             );
    //           }
    //         ),
    //       ),
    //       counterText: "",
    //       counterStyle: TextStyle(fontSize: 50),
    //       border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(20),
    //           borderSide: BorderSide(color: Colors.transparent)),
    //       focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(20),
    //           borderSide: BorderSide(color: Colors.transparent)),
    //       fillColor: AppColor.textFieldGrey,
    //       filled: true,
    //       disabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(20),
    //           borderSide: BorderSide(color: Colors.transparent)),
    //       enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(20),
    //           borderSide: BorderSide(color: Colors.transparent))),
    // );
    //

  }
}