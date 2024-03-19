
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
   CustomDropDown(
      {Key? key,
      required this.onChange,
      required this.value,
      required this.itemList,
      required this.title,
      this.mandatoryField = false,
      required this.isEnable,
      this.selectText="Select",
      this.isGrey=true,

      this.color,
      this.selecttextcolor,
      this.fontfamily,
      this.width,

      })
      : super(key: key);
  final Function(T value) onChange;
  final T? value;
  final List<T> itemList;
  final String title;
  final bool mandatoryField;
  final bool isEnable;
   bool isGrey;
  String selectText;


   final color;
   final selecttextcolor;
   final fontfamily;
   final width;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10.0),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(

              boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 0))
          ],
              color: AppColor.textFieldGrey, borderRadius: BorderRadius.circular(28)),
          height:56,width: width,
          child: Center(
            child: DropdownButton<T>(

              focusColor: AppColor.textFieldGrey,
              value: value,
              //elevation: 5,
              style:  TextStyle(color: Colors.red),
              items: itemList.map<DropdownMenuItem<T>>((T value)

              {
                return DropdownMenuItem<T>(
                  //alignment: Alignment.bottomCenter,


                  value: value,
                  child:Container(

                    margin: EdgeInsets.only(top: 10.0),
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,

                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(

                        child: Text(
                          (value as DropDownModel).getOptionName()!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColor.textLightBlueBlack,fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),


                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black87)
                          )
                        ),
                        width: double.maxFinite,

                      ),


                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      //   child: Divider(height: 1.0,color: Colors.black87,),
                      // )


                      //  Visibility(child: Divider(
                      //    color: Colors.black,
                      // //   height: 2.0,
                      //  thickness: 2,
                      //  //  indent: 5,
                      //
                      //  ))


                    ],
                  ),
                  )



                );
              }).toList(),
              isExpanded: true,
              underline: const SizedBox(),
              hint: Text(
                selectText,
                style: TextStyle(
                    color:isGrey? AppColor.textGreyColor:Colors.black,
                    fontSize: 15,
                    fontFamily: fontfamily,
                    fontWeight: FontWeight.bold),
              ),


              dropdownColor: Colors.white,

              onChanged: !isEnable
                  ? null
                  : (T? value) {
                      // setState(() {
                      onChange(value!);

                      // });
                    },
            ),
          ),
        ),



      ],
    );
  }
}

class DropDownModel {
  String? getOptionName() {}
}


class PetTypeModl implements DropDownModel {
  late final String title;
  late final String typeId;

  PetTypeModl({
    required this.title,
    required this.typeId,
   
  });

  @override
  String? getOptionName() {
    return title;
  }
}
