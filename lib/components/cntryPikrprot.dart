
import 'package:country_picker/country_picker.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/petprovider.dart';
import '../util/app_font.dart';

class CntrePikrProt extends StatefulWidget {
  final TextEditingController? phoneNumController;
  int inx;
  String countryCode;
  String countryFlag;

  CntrePikrProt({Key? key, this.phoneNumController, required this.inx,this.countryCode="",this.countryFlag=""})
      : super(key: key);

  @override
  State<CntrePikrProt> createState() => _CntrePikrProtState();
}

class _CntrePikrProtState extends State<CntrePikrProt> {
  String CountryCodeprot = "GB";
  String PhoneCodeprot = "44";
  String flagprot = "🇬🇧";
  String s1="44";
@override
  void initState() {
 PetProvider petProvider=Provider.of(context,listen: false);

 s1=widget.countryCode.replaceFirst("+", "");

 // petProvider.getContryFlag(widget.countryCode);
 print("===flag===>${s1}");

 if(widget.countryCode.isEmpty){
   widget.countryCode="44";
 }

    super.initState();
  }

  @override



  Widget build(BuildContext context) {
    print("country code is ${widget.countryFlag}");



    return Consumer<PetProvider>(builder: (context, petProvider, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.textFieldGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  showCountryPicker(
                      searchAutofocus: false,
                      context: context,
                      onSelect: (Country cntry) {
                        AuthProvider auth = Provider.of(context, listen: false);
                        PetProvider pet = Provider.of(context, listen: false);

                        print("=====phoneCode  phoneCode =${cntry.phoneCode}");

                        String str = cntry.phoneCode.toString();
                        print("=========********========= ${str}");

                        if (cntry.phoneCode.toString().isEmpty) {
                          print("=========********=========");
                        }

                        pet.petProtPhCode = cntry.phoneCode;
                        pet.petProtFlag = cntry.flagEmoji;

                        pet.setProtectionFlagVals(widget.inx,cntry.phoneCode,cntry.flagEmoji);

                        // pet.xtraPhNumlist[widget.inx].cntyCode = "+" + cntry.phoneCode;
                        // pet.xtraPhNumlist[widget.inx].cntyflag=cntry.flagEmoji;
                      for(var item in pet.xtraPhNumlist){
                        print("flag is ${item.cntyflag}");
                      }


                        print("=====indexc=${widget.inx}");

                        print("=====set values = == >> ${pet.xtraPhNumlist[widget.inx].cntyCode}");

                        auth.settttCountreee1(cntry.phoneCode,
                            cntry.countryCode, cntry.flagEmoji);

                        pet.cntrCodeProt = '';
                        pet.cntrCodeProt = "+" + cntry.phoneCode;
                        // print(
                        //     "=====countryCode prot to be set=====${pet.cntrCodeProt}");
                        //
                        // print("=====countryCode prot sc=====${cntry.countryCode}");
                        // print("=====phoneCode prot sc=${cntry.phoneCode}");
                        // print(cntry.flagEmoji);

                        // CountryCodeprot = cntry.countryCode.toString();
                        // PhoneCodeprot = cntry.phoneCode.toString();
                        //
                        // flagprot = cntry.flagEmoji.toString();
                        setState(() {});
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
                        child:
                        // Text( petProvider.xtraPhNumlist[widget.inx].cntyflag??"🇬🇧",
                        Text(widget.countryFlag,
                        // Text(petProvider.petProtFlag,

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
                        child:

                        Text(
                            widget.countryCode.isEmpty? "(44)":

                            "(${widget.countryCode.replaceFirst("+", "")})",
                        // Text("(${petProvider.petProtPhCode})",

                            style: TextStyle(
                                color: AppColor.textLightBlueBlack,
                                fontFamily: AppFont.poppinsMedium,
                                fontSize: 18.0)),
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 7,
                child: TextField(
                  onTap: (){
                    print("widget val==>${widget.countryCode}");
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
    });
  }
}
