import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  CustomDropDown({
    Key? key,
    required this.onChange,
    required this.value,
    required this.itemList,
    required this.title,
    this.mandatoryField = false,
    required this.isEnable,
    this.selectText = "Select",
    this.isGrey = true,
    this.color,
    this.selecttextcolor,
    this.fontfamily,
    this.width,
  }) : super(key: key);
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 0))],
              color: AppColor.textFieldGrey,
              border: Border.all(color: const Color(0xffCCCCCC)),
              borderRadius: BorderRadius.circular(8)),
          height: 54,
          width: width,
          child: Center(
            child: DropdownButton<T>(
              focusColor: AppColor.textFieldGrey,
              value: value,
              //elevation: 5,
              style: const TextStyle(color: Colors.red),
              items: itemList.map<DropdownMenuItem<T>>((T value) {
                return DropdownMenuItem<T>(
                    //alignment: Alignment.bottomCenter,

                    value: value,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black87))),
                            width: double.maxFinite,
                            child: Text(
                              (value as DropDownModel).getOptionName()!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: AppColor.textLightBlueBlack, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ));
              }).toList(),
              isExpanded: true,
              underline: const SizedBox(),
              hint: Text(
                selectText,
                style: TextStyle(
                    color: isGrey ? AppColor.textGreyColor : Colors.black,
                    fontSize: 15,
                    fontFamily: fontfamily,
                    fontWeight: FontWeight.bold),
              ),

              dropdownColor: Colors.white,

              onChanged: !isEnable
                  ? null
                  : (T? value) {
                      // setState(() {
                      onChange(value as T);

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
  String? getOptionName() {
    return null;
  }
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
