
import 'package:country_picker/country_picker.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/petprovider.dart';
import '../util/app_font.dart';

class CntrePikrProt2 extends StatefulWidget {
  final TextEditingController? phoneNumController2;
  int inx;

  CntrePikrProt2({
    Key? key,
    this.phoneNumController2,required this.inx
  }) : super(key: key);

  @override
  State<CntrePikrProt2> createState() => _CntrePikrProt2State();
}

class _CntrePikrProt2State extends State<CntrePikrProt2> {
  String CountryCodeprot = "GB";
  String PhoneCodeprot = "44";
  String flagprot = "🇬🇧";
  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
        builder: (context,petProvider,child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColor.textFieldGrey,
              borderRadius:BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                InkWell(
                    onTap:(){
                      showCountryPicker(
                          searchAutofocus: false,
                          context: context,
                          onSelect:(Country cntry){
                            AuthProvider auth = Provider.of(context, listen: false);
                            PetProvider pet = Provider.of(context, listen: false);


                            print("=====phoneCode  phoneCode =${cntry.phoneCode}");


                            String str=cntry.phoneCode.toString();
                            print("=========********========= ${str}");

                            if(cntry.phoneCode.toString().isEmpty){

                              print("=========********=========");

                            }

                            pet.petProtPhCode3=cntry.phoneCode;
                            pet.petProtFlag3=cntry.flagEmoji;

                            pet.xtraPhNumlist[widget.inx].cntyCode = "+" + cntry.phoneCode;

                            print("=====indexc=${widget.inx}");

                            print("=====set values = == >> ${ pet.xtraPhNumlist[widget.inx].cntyCode}");


                            // auth.settttCountreee1(
                            //     cntry.phoneCode, cntry.countryCode, cntry.flagEmoji
                            // );

                            pet.cntrCodeProt = '';
                            pet.cntrCodeProt = "+" + cntry.phoneCode;
                            print(
                                "=====countryCode prot to be set=====${pet.cntrCodeProt}");

                            print("=====countryCode prot sc=====${cntry.countryCode}");
                            print("=====phoneCode prot sc=${cntry.phoneCode}");
                            print(cntry.flagEmoji);

                            CountryCodeprot = cntry.countryCode.toString();
                            PhoneCodeprot = cntry.phoneCode.toString();

                            flagprot = cntry.flagEmoji.toString();
                            setState(() {});
                          }
                      );
                    },

                    child:Container(
                      height: 45,
                      width: 125,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(petProvider.petProtFlag3, style: TextStyle(fontSize: 20.0)),
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
                            child: Text("(${petProvider.petProtPhCode3})",
                                style: TextStyle(
                                    color: AppColor.textLightBlueBlack,
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 18.0)),
                          )
                        ],

                      ),

                    )


                ),

                Expanded(
                    flex: 7,
                    child: TextField(
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: AppColor.textLightBlueBlack,
                        fontFamily: AppFont.poppinsMedium,
                        fontSize: 18.0,
                      ),

                      controller: widget.phoneNumController2,
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

                    )


                )


              ],
            ),


          );





        }
    );
  }
}



