import 'package:country_picker/country_picker.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../util/app_font.dart';

class CntrePikr extends StatefulWidget {
  final TextEditingController? phoneNumController;
  const CntrePikr({Key? key, this.phoneNumController}) : super(key: key);

  @override
  State<CntrePikr> createState() => _CntrePikrState();
}

class _CntrePikrState extends State<CntrePikr> {
  String CountryCode = "GB";
  String PhoneCode = "44";
  String flag = "🇬🇧";
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.textFieldGrey,
        borderRadius:BorderRadius.circular(20),
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
                    //  auth.setCountry(cntry.countryCode,cntry.phoneCode,cntry.flagEmoji);

                    auth.settttCountreee1(
                        // cntry.countryCode,

                        cntry.phoneCode,
                        cntry.countryCode,
                        cntry.flagEmoji);

                    print("=====countryCode=====${cntry.countryCode}");
                    print("=====phoneCode=${cntry.phoneCode}");
                    print(cntry.flagEmoji);
                    CountryCode = cntry.countryCode.toString();
                    PhoneCode = cntry.phoneCode.toString();
                    flag = cntry.flagEmoji.toString();
                    setState(() {});
                  });
            },
            child: Container(

              height: 40,
              width: 125,
              decoration: BoxDecoration(
                // color: Colors.blue,
                      border: Border.all(color: Colors.transparent)

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(flag, style: TextStyle(fontSize: 20.0)),
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
                    child: Text("(${PhoneCode})",
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
  }
}
