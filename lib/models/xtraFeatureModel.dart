import 'package:flutter/material.dart';

class XtraFeature {
  String? FeatureName;
  int? FeatureType;

  XtraFeature({
    required this.FeatureName,
    required this.FeatureType,
  });
}

List<PetModel> PetFraturelist = [];

class PetModel {
  int? type;
  String? SpFechr;
  TextEditingController? controller;

  PetModel({
    required this.controller,
    required this.type,
    required this.SpFechr,
  });
}

class ContactModel {
  int? num;
  String? xtraContact;
  TextEditingController? controller;

  ContactModel({
    required this.controller,
    required this.num,
    required this.xtraContact,
  });
}

class CheckPresent {
  int? idPet;
  int? type;

  CheckPresent({this.idPet, this.type});
}

class xtraPhNumModel {
  String? cntyCode;
  String? cntyflag;
  TextEditingController? controller;


  xtraPhNumModel({required this.cntyCode, required this.controller, this.cntyflag});
}
