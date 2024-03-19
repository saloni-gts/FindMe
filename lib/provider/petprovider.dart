import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/api/call_api.dart';
import 'package:find_me/api/staus_enum.dart';
import 'package:find_me/components/customdropdown.dart';
import 'package:find_me/models/MsngrModel.dart';
import 'package:find_me/models/documentDetailV2.dart';
import 'package:find_me/models/documentdetailmodel.dart';
import 'package:find_me/models/editNotesModel.dart';
import 'package:find_me/models/masterDetailModel.dart';
import 'package:find_me/models/notesDetailModel.dart';
import 'package:find_me/models/petdetailsmodel.dart';
import 'package:find_me/models/tagDetailModel.dart';
import 'package:find_me/models/usermodel.dart';
import 'package:find_me/models/weightDetailModel.dart';
import 'package:find_me/models/xtraFeatureModel.dart';
import 'package:find_me/monish/models/Locationlist.dart';
import 'package:find_me/monish/models/newModel.dart';
import 'package:find_me/monish/provider/mapProvider.dart';
import 'package:find_me/monish/provider/myProvider.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/provider/purchase_provider.dart';
import 'package:find_me/util/app_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../components/addMobNum.dart';
import '../components/globalnavigatorkey.dart';
import '../models/eventDetailsModel.dart';
import '../models/getPhotosModel.dart';
import '../models/healthCardModel.dart';
import '../models/masterEvent.dart';
import '../models/newEventDetails.dart';
import '../models/petProtectionModel.dart';
import '../models/verified_list_api_model.dart';
import '../screen/PhotoGallery.dart';
import '../services/hive_handler.dart';

class PetProvider extends ChangeNotifier {
  TextEditingController petNameController = TextEditingController();
  TextEditingController petmicrochipController = TextEditingController();

  TextEditingController weightDescCntrolr = TextEditingController();

  TextEditingController petweightCntrolr = TextEditingController();

  TextEditingController petProtMchip = TextEditingController();

  TextEditingController petRepeatEvent = TextEditingController();
  TextEditingController editpetRepeatEvent = TextEditingController();
  TextEditingController editRemindBefor = TextEditingController();

  // TextEditingController petHealtweightCntrolr = TextEditingController(text: "0.0");
  TextEditingController petHealtweightCntrolr = TextEditingController(text: "0.0");

  List<GetPetPhotos> images = [];
  VerifiedListApiModel? verifiedListApiModel;

  List<XtraFeature> ectaFeatureList = [];

  List<TextEditingController> controllers = [];
  List<int> petFeatureType = [];

  List<Map> _resourceList = [];

  List<PetModel> PetFraturelist = [];

  List<Map<String, dynamic>> featureMap = [];

  addToList() {
    featureMap.clear();
    print("feature map=====${featureMap}");

    for (int i = 0; i < PetFraturelist.length; i++) {
      Map<String, dynamic> map = {
        "type": PetFraturelist[i].type,
        "name": PetFraturelist[i].controller?.text.trim() ?? "",
      };
      String s1 = PetFraturelist[i].controller?.text.trim() ?? "";
      if (s1.isEmpty) {
      } else {
        featureMap.add(map);
      }

      // featureMap.add(map);
    }
  }

  incrementController(int type) {
    String title;
    print("type====>>> ${type}");
    switch (type) {
      case 1:
        title = "Special Feature";
        break;

      case 2:
        title = "Tattoos";
        break;

      case 3:
        title = "Clip";
        break;

      case 4:
        title = "Ring Number";
        break;

      case 5:
        title = "Internal Organization Number";
        break;

      case 6:
        title = "Account Number";
        break;

      case 7:
        title = "Breeding Book Number";
        break;

      case 8:
        title = "Other ID";
        break;

      default:
        title = "Other ID";
        break;
    }

    TextEditingController ctlr1 = new TextEditingController();

    bool _isAdd = false;
    for (int i = 0; i < PetFraturelist.length; i++) {
      print("type===>${PetFraturelist[i].type}  $type");
      if (PetFraturelist[i].type == type) {
        _isAdd = true;
      }
    }

    if (_isAdd) {
      EasyLoading.showToast("This field is already added");

      print('this is working');
    } else {
      PetFraturelist.add(
          PetModel(controller: ctlr1, type: type, SpFechr: title));
      notifyListeners();
    }

    print("the map type list===> ${PetFraturelist.length}");
  }

  List<Map<String, dynamic>> mesngrMap = [];

  addToMsngrList() {
    mesngrMap.clear();
    print("mesenger map=====${mesngrMap}");
    for (int i = 0; i < xtraContactlist.length; i++) {
      Map<String, dynamic> map = {
        "type": xtraContactlist[i].num,
        "name": xtraContactlist[i].controller?.text.trim() ?? "",
      };
      String s1 = xtraContactlist[i].controller?.text.trim() ?? "";
      if (s1.trim().isEmpty) {
      } else {
        mesngrMap.add(map);
      }

      // mesngrMap.add(map);
    }
  }

  List<ContactModel> xtraContactlist = [];

  List<CheckPresent> telegramList = [];

  String? title2;

  showTitile2(String val) {
    print("show title====>>${val}");
    title2 = val;
    notifyListeners();
  }

  incrementController2(int type) {
    String title;
    print("type====>>> ${type}");
    switch (type) {
      case 1:
        title = "Telegram";
        break;

      case 2:
        title = "Whatsapp";
        break;

      case 3:
        title = "Facebook Messenger";
        break;

      case 4:
        title = "Viber";
        break;

      case 5:
        title = "Other Number";
        break;

      default:
        title = "Other Number";
        break;
    }
    showTitile2(title);

    TextEditingController ctlr2 = new TextEditingController();

    print("******");
    print("ctlr2===>${ctlr2}");

    print("******");

    bool _isAdd = false;
    for (int i = 0; i < xtraContactlist.length; i++) {
      print("type===>${xtraContactlist[i].num}  $type");
      if (xtraContactlist[i].num == type) {
        _isAdd = true;
      }
    }

    if (_isAdd) {
      print('this is working');
      EasyLoading.showToast("This field is already added");
    } else {
      print('this is ctlr2${ctlr2}');
      xtraContactlist
          .add(ContactModel(controller: ctlr2, num: type, xtraContact: title));
      notifyListeners();
      print("the map type list===> ${xtraContactlist.length}");
    }
  }

  List<xtraPhNumModel> xtraPhNumlist = [];

  String cntrCodeProt = "";

  List<Map<String, dynamic>> PhNumMap = [];

  addToPhNumList(BuildContext context) {
    PhNumMap.clear();
    print("length==== >>> ${xtraPhNumlist.length}");
    for (int i = 0; i < xtraPhNumlist.length; i++) {
      print("print ioioioio====>> ${xtraPhNumlist[i].cntyCode}");

      if (xtraPhNumlist[i].cntyCode!.isEmpty) {
        xtraPhNumlist[i].cntyCode = "+44";
      }

      String s1 = xtraPhNumlist[i].controller?.text ?? "";
      Map<String, dynamic> map = {
        "countryCode": xtraPhNumlist[i].cntyCode,
        "mobileNumber": xtraPhNumlist[i].controller?.text.trim() ?? "",
      };
      if (s1 == 0 || s1.isEmpty) {
      } else {
        PhNumMap.add(map);
      }
      print("length====${PhNumMap.length}");
      // PhNumMap.add(map);
    }
  }

  incrementController3() {
    TextEditingController ctlr3 = new TextEditingController();
    print("controller value======>${ctlr3.text}");
    if (xtraPhNumlist.length < 3) {
      xtraPhNumlist.add(xtraPhNumModel(controller: ctlr3, cntyCode: ""));
      notifyListeners();
      print("the map type list===> ${xtraPhNumlist.length}");
    }
  }

  int locControler = 0;

  incrementLocControler() {
    locControler = locControler + 1;
    print("locControler${locControler}");
  }

  Map<String, dynamic> fetreMap = {};

  List<Map<String, dynamic>> XtraFeMap = [];

  //       "type" :  PetFraturelist[i].type,
  //       "name" : PetFraturelist[i].controller,

  incrementFechrType(int typefechr) {
    petFeatureType.add(typefechr);
    print("list of === >>> ${petFeatureType}");
  }

  bool loader = false;
  bool loaderlisten = false;

  String? eventpetname;
  String? eventpetphoto;

  updateLoader(bool status) async {
    loaderUpdate(status);

    loader = status;
    await Future.delayed(Duration(seconds: 0));
    notifyListeners();
  }

  int isDownload = 0;
  isCheckDownload() {
    isDownload = isDownload + 1;
  }

  var locIocPer = 0;
  setLocIocPer() {
    Future.delayed(Duration.zero, () async {
      locIocPer = 1;
      print("locIocPer===>> ${locIocPer}");
      notifyListeners();
    });

    print("locIocPerlocIocPer${locIocPer}");
  }

  updateLoaderListen(bool status) {
    loaderlisten = status;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  Map<String, List> mySelectedEvents = {};
  // List<Map<DateTime, List<Event>>> SelEvents=[];
  // List<Map<DateTime, List<Event>>> SelEvents=[];
  // getEventsfromDay(DateTime date){
  //   SelEvents.clear();
  //   for(var item in eventMainList){
  //
  //     if(item.convertedDate!=null){
  //       print("DATES OF EVENTS ${item.convertedDate}");
  //       setCalendarDot(item.convertedDate!,[Event(title: item?.eventName??"")]);
  //     }
  // //
  // //
  //   }
  //   print("LIST LENGTH ${SelEvents.length} ");
  //   // notifyListeners();
  //   return SelEvents?? [];
  // }
  // setCalendarDot(DateTime ddate,List<Event> event){
  //   SelEvents=SelEvents + [{ddate:event}];
  //    // SelEvents.add({ddate,[Event(title: titlee)] });
  //   // SelEvents.(ddate,[Event(title: "")]);
  //   // SelEvents[ddate]?.add(Event(title:titlee));
  // }
  int val = 1;
  List getEventsfromDay(DateTime date) {
    
  if (mySelectedEvents.isNotEmpty) {
      if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] != null) {
        return mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];
      } else {
        return mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];
      }
    } else {
      print("date is >>> ${date}");
      print("evtShowList length is >> ${evtShowList.length}");
      
      if (eventP2List.isEmpty) {
        print("list is empty....");
      }
      for (var item in eventP2List) {
        print("event names==>> ${item.eventName}");
        if (item.startDate != null) {
          setDate(item.startDate!, formatDateTym2(item.eventEndDate ?? ""),
              item.isRepeat ?? 0, item.eventName ?? "");
        }
      }
      if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] != null) {
        return mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];
      } else {
        return mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];
      }
    }
  }

  List<DateTime> days = [];
  List<DateTime> finalDaysList = [];

  setDate(DateTime date, DateTime date2, int repVal, String evtname) {
    print("start date:::: ${date}");
    var v1 = date.millisecondsSinceEpoch;

    mySelectedEvents[DateFormat('yyyy-MM-dd').format(date)] = [
      {"event": evtname}
    ];
  }

  String dateConverterpp(int date) {
    var d = DateTime.fromMillisecondsSinceEpoch(date);

    return "${Jiffy(d).format("EEE ")}".toUpperCase();
  }

  String dateCovtMonth(int date) {
    var d = DateTime.fromMillisecondsSinceEpoch(date);

    return "${Jiffy(d).format("dd ")}".toUpperCase();
  }

  removedocFile() {
    docFile = null;
    notifyListeners();
  }

  deleteNotesFile(int indx) {
    notesFile.removeAt(indx);
    notifyListeners();
  }

  loaderUpdate(bool status) {
    if (status) {
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.clear);
    } else {
      print("dismiss loader");
      EasyLoading.dismiss();
    }
  }

  AppApi api = AppApi();
  List<PetDetails> petDetailList = [];
  List<PetDetails> petDetailList2 = [];
  List<PetDetails> petDetailListJoint = [];

  PetDetails? selectedPetDetail;

  setNotificatedPetDetail(int refId) {
    if (petDetailList.isNotEmpty) {
      for (var item in petDetailList) {
        if (item.id == refId) {
          print("setting pet id${item}");
          setSelectedPetDetails(item);
        }
      }
    } else {
      selectedPetDetail = PetDetails(id: refId);
    }
  }

  var setselectedPetId;

  setSelectedPetDetails(PetDetails val) {
    selectedPetDetail = val;
    print("pet details call fucntion ${val.id}");

    setselectedPetId = selectedPetDetail?.id;

    print("set selected pet id===>>> ${setselectedPetId}");
  }

  onselectDocCate(PetTypeModl val) {
    selectedDocType = val;
    notifyListeners();
  }

  List<int> contactList = [];

  int addNum = 0;
  xtraNums() {
    addNum = addNum + 1;
    contactList.add(1);

    notifyListeners();
  }

  zeroNums() {
    addNum = 0;
    print("=====zero nums====>>> ${addNum}");
    notifyListeners();
  }

  updateSelectedData(int index) {
    for (var item in masterDetailList) {
      item.buttonisSelected = false;
    }
    masterDetailList[index].buttonisSelected = true;
    notifyListeners();
  }

  PetTypeModl? selectedPetType;
  PetTypeModl? selectedDocType;
  PetTypeModl? selectedMsngrType;

  PetTypeModl? selectedPetGender;
  PetTypeModl? selectedSerialization;
  PetTypeModl? selectedPetSize;

  bool radioVal = false;
  bool nvrRadVal = false;
  File? petImage;
  File? userImage;
  File? docFile;
  int docFileType = 0;
  int notesFileType = 0;

  List<DocumentDetails> documentList = [];
  List<DocumentDetails> TotaldocumentList = [];
  List<DocumentDetailsV2> documentListV2 = [];

  List<TagDetails> qrTagList = [];
  List<WeightDetails> weightList = [];
  DocumentDetails? selectedDocument;
  List<EventDetails> eventList = [];
  List<EventModel> eventNewwwList = [];
  List<EventModel> eventNewwwMainList = [];

  List<EventModel> evtShowList = [];

  List<EventDetails> eventMainList = [];

  List<EventModel> eventP2List = [];

  List<NotesDetails> notesList = [];

  List<LocationListDetails> locationList = [];
  LocationListDetails? locationdetail;

  EventDetails? selectedEvent;
  EventDetails? selectedEventype;
  NotesDetails? selectedNotes;
  WeightDetails? selectedWeight;
  TagDetails? selectedTag;
  HealthCard? selectedCard;

  EventModel? seleectedEvnt;

  List<DateTime> getDays({required DateTime start, required DateTime end}) {
    final days = end.difference(start).inDays;

    return [for (int i = 0; i < days; i++) start.add(Duration(days: i))];
  }

  DateTime? valDate;
  String strValDate = "";

 List<EventModel> filterData(DateTime val) {
    print("inside func");
    valDate = val;
    strValDate = val.toString();
    evtShowList = [];
    evtShowList = eventP2List
        .where((element) =>
            DateFormat('yyyy-MM-dd')
                .format(element.startDate ?? DateTime.parse("2022-10-21")) ==
            DateFormat('yyyy-MM-dd').format(val))
        .toList();
        return evtShowList;
    // notifyListeners();
  }

  setSelectedDocuments(DocumentDetails val) {
    selectedDocument = val;
  }

  setSelectedCard(HealthCard val) {
    selectedCard = val;
  }

  setSelectedQrTag(TagDetails val) {
    selectedTag = val;
  }

  setSelectedEvents(EventDetails val) {
    print("test2");
    selectedEvent = val;
    notifyListeners();
  }

  setSelNewEvnt(EventModel val) {
    print("test2");
    seleectedEvnt = val;
    notifyListeners();
  }

  setSelectedNotes(NotesDetails val) {
    print("test2");
    selectedNotes = val;
    notifyListeners();
  }

  setSelectedWeight(WeightDetails val) {
    selectedWeight = val;

    // notifyListeners();
  }

  deleteDocument(BuildContext context) async {
    updateLoader(true);
    await api.callDeleteDocApi({
      "petId": selectedDocument?.petId ?? "",
      "id": selectedDocument?.id ?? ""
    }).then((value) async {
      if (value.status == Status.success) {
        updateLoader(false);
        await GetDocV2();
        // await callGetDoc();

        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pop(context);
      } else {
        updateLoader(false);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  updateImage(File fil) {
    petImage = fil;
    notifyListeners();
  }

  addDocFile(File doc, int typ) {
    docFileType = typ;
    docFile = doc;
    notifyListeners();
  }

  List<File> notesFile = [];
  addNotesFile(File doc, int typ) {
    notesFileType = typ;
    notesFile.add(doc);
    print("notes added!!!");
    print("======>>>>>>>> ${notesFile.length}");
    notifyListeners();
  }

  List<NotesImgEditModel> editNoteList = [];

  NotesImgEdit() {
    editNoteList.clear();
    for (int i = 0; i < selectedNotes!.image.length; i++) {
      // editNoteList.add(NotesImgEditModel(Imgurl: selectedNotes!.image[i].url, type: 1));
      // editNoteList.add(NotesImgEditModel(Imgurl: selectedNotes!.image[i].url, type: 1));
      editNoteList.add(NotesImgEditModel(Imgurl: selectedNotes!.image[i].halfUrl, type: 1));
    }
    print("List === ${editNoteList}");
  }

  List<File> editNotesImgLts = [];

  editNotesFile(File doc, int typ) {
    notesFileType = typ;
    editNoteList.add(NotesImgEditModel(type: 2, file1: doc));

    print("notes added!!!");
    print("edited list=== ${editNoteList}");

    notifyListeners();
  }

  deleteEditNotes(int indx) {
    editNoteList.removeAt(indx);
    print("===== ${editNoteList}");
    notifyListeners();
  }

  // callGetDoc() async {
  //   updateLoader(true);
  //   updateLoaderListen(true);
  //   await api
  //       .getDocumentsApi({"petId": selectedPetDetail?.id ?? ""}).then((value) {
  //     updateLoader(false);
  //     updateLoaderListen(false);
  //     if (value.status == Status.success) {
  //       documentList.clear();
  //       List temp = value.data["documents"] ?? [];
  //       documentList = temp.map((e) => DocumentDetails.fromjson(e)).toList();
  //     } else {
  //       updateLoader(false);
  //       documentList = [];
  //     }
  //     notifyListeners();
  //   });
  // }

  List<int?> sharedPremIds=[];

  callAddDocument(
      {required String doctitle,
      required String docDate,
      required BuildContext context,
      int? filetype}) async {
    if (docFile != null) {
      List images = [
        {"key": "image", "image": docFile}
      ];
      updateLoader(true);
      await api.callUploadPetImage(true, images).then((value) async {
        if (value.status == Status.success) {
          print("IMAGE OR FILEE NAMEE ${value.data["fileName"]}");
          String filee = value.data["fileName"];
          Map<String, dynamic> bodyy = {
            "petId": selectedPetDetail?.id ?? "",
            "documentUrl": filee,
            "catagoryId": 1,
            "title": doctitle,
            "isUsedDate": docDate,
            "fileType": filetype,
          };
          print("REQUESTTT $bodyy");
          await api.addDocumentsApi(bodyy).then((value) async {
            updateLoader(false);
            if (value.status == Status.success) {
              await GetDocV2();
              // await callGetDoc();
              await CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: value.message);

              Navigator.pop(context);
            } else {
              updateLoader(false);
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: value.message);
            }
          }).onError((error, stackTrace) => updateLoader(false));
        } else {
          updateLoader(false);
        }
      });
      //.onError((error, stackTrace) => updateLoader(false));
    }
  }

  getAllPet() async {
    await api.getPetApiCall().then((value) {
      petDetailList.clear();
      if (value.status == Status.success) {
        petDetailList.clear();
        List temp = value.data["petDetails"] ?? [];
        List temp2 = value.data["JointPet"] ?? [];
        print("lemgth of my pets ${temp.length}");
        print("lemgth of join  pets ${temp2.length}");


        petDetailList2 = temp.map((e) => PetDetails.fromjs(e, false)).toList();
        petDetailListJoint = temp2.map((e) => PetDetails.fromjs(e, false)).toList();

     print("petDetailListJoint===${petDetailListJoint.length}");

        print("petDetailList2====${petDetailList2}");
        sharedPremIds.clear();
        for(int i=0;i<petDetailListJoint.length;i++){
          print("petDetailList2 name ${petDetailListJoint[i].petName} and isprem====${petDetailListJoint[i].isPremium}   ${petDetailListJoint[i].id}");
         if(petDetailListJoint[i].isPremium==1) {
           sharedPremIds.add(petDetailListJoint[i].id);
           print("petDetailList2[i].id===${petDetailListJoint[i].id}");
         }
        }
        print("final list===${sharedPremIds}");

        petDetailList.addAll(temp.map((e) => PetDetails.fromjs(e, false)));
        petDetailList.addAll(temp2.map((e) => PetDetails.fromjs(e, true)));
        print("lemgth of all  pets ${petDetailList.length}");
        for(int i=0;i<petDetailListJoint.length;i++){
          print("${petDetailListJoint[i].id}");
        }

      } else {
        petDetailList = [];
      }
      notifyListeners();
    });
        // .onError((error, stackTrace) => updateLoader(false));
  }

  addPetCalling(
      {required String petnme,
      required String microchipp,
      required String bdate,
      required String bred,
      required String petcolr,
      required String shortdesc,
      required String contact,
      required String city,
      required BuildContext contxt}) async {
    String urlofimage = "";
    if (petImage != null) {
      List images = [
        {"key": "image", "image": petImage}
      ];
      updateLoader(true);
      await api.callUploadPetImage(true, images).then((value) {
        // updateLoader(false);
        if (value.status == Status.success) {
          updateLoader(false);
          urlofimage = value.data["fileName"];
        }
      }).onError((error, stackTrace) => updateLoader(false));
      // callUpload
    }

    Map<String, dynamic> body = {
      "petImage": urlofimage,
      "petName": petnme,
      "petType": selectedPetType?.typeId,
      "microChip": microchipp,
      "birthDate": bdate,
      "breed": bred,
      "gender": selectedPetGender?.typeId ?? "",
      "sterilization": selectedSerialization?.typeId ?? "",
      "color": petcolr,
      "size": selectedPetSize?.typeId ?? "",
      "description": shortdesc,
      "contact": contact,
      "city": city,
      "status":addPremPet,
    };
    updateLoader(false);
    await api.callAddPetApii(body).then((value) async {
      updateLoader(false);
      print("status value ;;;;;${value.status}");

      if (value.status == Status.inValidMob) {
        updateLoader(false);
        addPhoneNumberDialog(contxt);
      } else if (value.status == Status.success) {

        // if(isUserPremium==1){
        //   addPetPremApiCall();
        // }
        // addPremPet

        updateLoader(false);
        await getAllPet();
        await CoolAlert.show(
            context: contxt, type: CoolAlertType.success, text: value.message);
        Navigator.pop(contxt);
      } else {
        updateLoader(false);
        CoolAlert.show(
            context: contxt, type: CoolAlertType.error, text: value.message);
      }
    });
        // .onError((error, stackTrace) => updateLoader(false));
  }

  deletePet(BuildContext context, Map<String, dynamic> body) async {
    updateLoader(true);
    await api.deletecallApi(body).then((value) async {
      if (value.status == Status.success) {
        await getAllPet();
        await updateLoader(false);
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pushNamedAndRemoveUntil(
            context, AppScreen.dashboard, (r) => false);
      } else {
        updateLoader(false);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  updatePetCalling(
      {required String petnme,
      required String microchipp,
      required String bdate,
      required String bred,
      required String petcolr,
      required String shortdesc,
      required String contact,
      required String city,

      required BuildContext contxt}) async {


    if(isUserPremium==1){
      print("isUserPremium======>${isUserPremium}");


      await setPetPremApiCall();
    }
    print("pet4Prem=${pet4Prem}");
    if(pet4Prem==1){
      return;
    }


    String urlofimage = "";
    if (petImage != null) {
      List images = [
        {"key": "image", "image": petImage}
      ];
      updateLoader(true);
      await api.callUploadPetImage(true, images).then((value) {
        // updateLoader(false);
        if (value.status == Status.success) {
          updateLoader(false);
          urlofimage = value.data["fileName"];
        }
      });
      // .onError((error, stackTrace) => updateLoader(false));
      // callUpload
    } else {
      String pic = selectedPetDetail?.petPhoto ?? "";
      if (pic.isEmpty) {
        urlofimage = " ";
      }
    }

    Map<String, dynamic> body = {
      "petId": selectedPetDetail?.id ?? 0,
      "image": urlofimage,
      "petName": petnme,
      "petType": selectedPetType?.typeId,
      "microChip": microchipp,
      "birthDate": bdate,
      "breed": bred,
      "gender": selectedPetGender?.typeId ?? " ",
      "sterilization": selectedSerialization?.typeId ?? " ",
      "color": petcolr,
      "size": selectedPetSize?.typeId ?? " ",
      "description": shortdesc,
      "contact": contact,
      "city": city

    };
    updateLoader(true);
    await api.callupdatePetApii(body).then((value) async {
      if (value.status == Status.success) {
        print("**************************");

        if(isUserPremium==1){
          print("isUserPremium======>${isUserPremium}");
          // setPetPremApiCall();
        }


        print("**************************");
        await getAllPet();
        isShowSheild();
        updateLoader(false);




        for (var item in petDetailList) {
          if (item.id == selectedPetDetail?.id) {
            selectedPetDetail = item;
            notifyListeners();
          }
        }
        isShowSheild();
        await CoolAlert.show(
            context: contxt, type: CoolAlertType.success, text: value.message);
        Navigator.pop(contxt);
      } else {
        updateLoader(false);
        CoolAlert.show(context: contxt, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) {
      print("error message==== >>> ${error}");
      updateLoader(false);
    });
    // print("error message==== >>> ${error}");
  }

  clearContent() {
    petNameController.clear();
    petmicrochipController.clear();
    selectedPetType = null;
    selectedPetGender = null;
    selectedSerialization = null;
    selectedPetSize = null;
    petImage = null;
  }

  onRadioChange() {
    radioVal = !radioVal;
    notifyListeners();
  }

  onEvntRadioChange() {
    nvrRadVal = !nvrRadVal;
    notifyListeners();
  }

  onselectPetType(PetTypeModl val) {
    selectedPetType = val;
    notifyListeners();
  }

  onselectCataType(CatagoryList val) {
    selectedSubCategory = val;

    print("categoryyyyyy===>>> ${selectedSubCategory!.categoriesId}");
    notifyListeners();
  }

  onselectEventType(EvntCatagoryList val) {
    selectedSubEvnt = val;

    print("categoryyyyyy===>>> ${selectedSubCategory?.categoriesId ?? 0}");
    notifyListeners();
  }

  onselectPetGender(PetTypeModl val) {
    selectedPetGender = val;

    notifyListeners();
  }

  onSerializationSelect(PetTypeModl val) {
    selectedSerialization = val;
    notifyListeners();
  }

  onselectPetSize(PetTypeModl val) {
    selectedPetSize = val;
    notifyListeners();
  }

  getPetPhotoCall({required BuildContext context, isNavigate = false}) async {
    updateLoader(true);
    await api.getPetPhotosGallery({"petId": selectedPetDetail?.id ?? ""}).then(
        (value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        List temp = value.data["photos"] ?? [];
        images = temp.map((e) => GetPetPhotos.fromJson(e)).toList();
        print("**********${value.data}***********");
        notifyListeners();
        if (isNavigate) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PhotoGallery()));
        }
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  Future deletePetPhotoCall(Map<String, dynamic> body,
      {required BuildContext context}) async {
    updateLoader(true);
    await api.deletePetPhotos(body).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        await getPetPhotoCall(context: context);

        CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        updateLoader(false);
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  Future petMarkAsLost({required BuildContext context}) async {
    Map<String, dynamic> bodyy = {
      "petId": selectedPetDetail?.id,
      "isLost": selectedPetDetail?.isLost == 1 ? 0 : 1,
    };
    updateLoader(true);
    await api.petLostApi(bodyy).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        await getAllPet();
        for (var item in petDetailList) {
          if (item.id == selectedPetDetail?.id) {
            selectedPetDetail = item;
            notifyListeners();
          }
        }
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  Position? PostiProvidr;
  Position? PostiProvidr2;

  double? lati;
  double? longi;

  Future petMarkAsLostP2({required BuildContext context}) async {
    Map<String, dynamic> bodyy = {
      "petId": selectedPetDetail?.id,
      "latitude": lati,
      "longitude": longi,
      "isLost": selectedPetDetail?.isLost == 1 ? 0 : 1,
    };
    updateLoader(true);
    await api.petLostApiP2(bodyy).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        await getAllPet();
        for (var item in petDetailList) {
          if (item.id == selectedPetDetail?.id) {
            selectedPetDetail = item;
            notifyListeners();
          }
        }
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  Myprovider myProvider =
      Provider.of(GlobalVariable.navState.currentContext!, listen: false);
  Future calleditProfileP2Api({required BuildContext context}) async {
    // Myprovider myProvider=Provider.of(context,listen: false);

    if (lati == null) {
      lati = 0.0;
      return;
    }
    if (longi == null) {
      return;
      longi = 0.0;
    }

    Map<String, dynamic> bodyy = {
      "lat": lati,
      "long": longi,
    };
    updateLoader(true);
    HiveHandler.updateLocPopup(true);
    bool isSelected = await HiveHandler.isLocSeclected();
    print("Show location popup after first popup==>${isSelected}");

    await api.editProfileP2Api(bodyy).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        myProvider.callsendNotificationApi(iddd: 1, status: 1);
        myProvider.chngSetButton();
        AuthProvider auth = Provider.of(context, listen: false);
        auth.isNewLogin = 0;
        // print()
        print("calleditProfileP2Api success");
        updateLoader(false);
      } else {
        updateLoader(false);
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
        updateLoader(false);
      }
    }).whenComplete(() => updateLoader(false));
    // .onError((error, stackTrace) =>
    // Future(() => updateLoader(false))
    // updateLoader(false)
    // );
  }

  uploadImagePet({required File f1, required BuildContext contxt}) async {
    List images = [
      {"key": "image", "image": f1}
    ];
    updateLoader(true);
    await api.callUploadPetImage(true, images).then((value) async {
      // updateLoader(false);
      if (value.status == Status.success) {
        String urlofimage = value.data["fileName"];
        print("//////******$urlofimage");
        await api.addPetPhotosApi({
          "petImages": urlofimage,
          "petId": selectedPetDetail?.id ?? ""
        }).onError((error, stackTrace) => updateLoader(false));
        if (value.status == Status.success) {
          updateLoader(false);
          print("*******************************{images.length}");
          await getPetPhotoCall(context: contxt);
          CoolAlert.show(
              context: contxt,
              type: CoolAlertType.success,
              text: value.message);
          // Navigator.pop(contxt);
        } else {
          updateLoader(false);
          CoolAlert.show(
              context: contxt, type: CoolAlertType.error, text: value.message);
        }
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  qrCodeActivatinTag(Map<String, dynamic> body,
      {required BuildContext context}) async {
    print("***************$body");
    updateLoader(true);
    await api.attachQrToPet(body).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        await getAllPet();
        await callGetQrTag();
        isShowSheild();
        for (var item in petDetailList) {
          if (item.id == selectedPetDetail?.id) {
            selectedPetDetail = item;
            notifyListeners();
          }
        }

        Navigator.pop(context);
        // Navigator.pop(context);
        print(value.data);
        CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
      } else {
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  petDocumentEdit(
      {required BuildContext context,
      required String time,
      required String name,
      int? filetype}) async {
    Map<String, dynamic> bodyy = {
      "petId": selectedDocument?.petId,
      "documentUrl": "",
      "catagoryId": selectedDocType?.typeId,
      // "catagoryId": 1,
      "title": name,
      "issuedDate": time,
      "id": selectedDocument?.id,
      "fileType": filetype,
    };

    updateLoader(true);
    await api.editDocApi(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        await GetDocV2();
        // await callGetDoc();
        for (var item in documentList) {
          if (item.id == selectedDocument?.id) {
            selectedDocument = item;
          }
        }
        notifyListeners();

        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        // Navigator.pop(GlobalVariable.navState.currentContext!);
        Navigator.pop(context);
      } else {
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  deleteEventApiCall(
      {required BuildContext context,
      required var year,
      required var month,
      required int idddd,
      required int petiddd,
      required bool frmpet}) async {
    updateLoader(true);
    print("value of year=>${year}");
    print("value of month=>${month}");
    var neMon = month - 1;

    await api
        .deleteEventsApi({"petId": petiddd, "id": idddd}).then((value) async {
      mySelectedEvents = {};
      mySelectedEvents.clear();
      eventMainList.clear();
      if (value.status == Status.success) {
        updateLoader(false);
        print("is from pet=======>${frmpet}");
        await callgetPetEventP2(
            DateTime.now().month, DateTime.now().month, frmpet);
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        focusedDayyPP = DateTime(year, neMon, 30);
        // focusedDayyPP=DateTime.now();
        print("focusedDayyPP${focusedDayyPP}");
        Navigator.pop(context);
      } else {
        updateLoader(false);
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  // callGetEvents() async {
  //   updateLoader(true);
  //   updateLoaderListen(true);
  //   await api.getAllPetEventsApi({}).then((value) {
  //     updateLoader(false);
  //     updateLoaderListen(false);
  //
  //     if (value.status == Status.success) {
  //       eventMainList.clear();
  //       List temp = value.data["eventLists"] ?? [];
  //
  //       eventMainList = temp.map((e) => EventDetails.fromjson(e)).toList();
  //
  //       // eventList = eventMainList;
  //     } else {
  //       eventMainList = [];
  //     }
  //     // notifyListeners();
  //     filterData(DateTime.now());
  //   });
  // }

// var loadPercent;
  var displayLoad;
  void setLoadVal(loadPercent) {
    displayLoad = loadPercent;
    notifyListeners();
  }

  PerDateEvnt(int thisDate) {
    for (int i = 0; i < eventP2List.length; i++) {
      print("evenr end date==${converterr(eventP2List[i].eventEndDate ?? "")}");
      evtShowList = [];
      evtShowList = eventP2List
          .where((element) =>
              converterr(eventP2List[i].eventEndDate ?? "") >= thisDate)
          .toList();
    }
  }

  int converterr(String intgr) {
    if (intgr.isNotEmpty) {
      var now = DateTime.fromMillisecondsSinceEpoch(int.parse(intgr));
      var va1 = now.millisecondsSinceEpoch;
      return va1;
    } else {
      return 1;
    }
  }

  chkStatus(String st) {
    var start = st;

    if (repeatType == 1) {
      /// day
    } else if (repeatType == 2) {
      /// week    day
    } else if (repeatType == 3) {
      /// month    date

      for (int i = 0; i < eventP2List.length; i++) {
        if (eventP2List[i].startDate == start) {}
      }
    } else if (repeatType == 4) {
      ///year   date
    }
  }

  int isShowPremiumBorder = 0;
  showPremiumBorder() {
    isShowPremiumBorder = 1;
    notifyListeners();
  }

  callgetPetEventP2(int month, int year, bool isfrompet) async {
    print("call get pet event p2");
    mySelectedEvents.clear();
    Map<String, dynamic> bodyy = {};
    bodyy = {
      "month": month,
      "year": year,
    };
    
    isfrompet ? bodyy.putIfAbsent("petId", () => selectedPetDetail?.id) : null;

    updateLoader(true);
    await api.getAllPetEvent(bodyy).then((value) {
      if (value.status == Status.success) {
        eventP2List.clear();

        List temp = value.data["eventLists"] ?? [];

        eventP2List = temp.map((e) => EventModel.fromJson(e)).toList();
        print("length of list===>>${eventP2List.length}");
        // for(int i=0;i<eventP2List.length;i++){
        //   print("all events names===>>${eventP2List[i].eventName}");
        // }

        // evtShowList.clear();

        evtShowList = eventP2List;
        print("length show list  ===>>${evtShowList.length}");
        print("length eventP2List list ===>>${eventP2List.length}");

        filterData(DateTime.now());
        updateLoader(false);
      } else {
        eventP2List = [];
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      updateLoader(false);
    });
  }

  callEditEvent(
      {required BuildContext context,
      required String time,
      required String name,
      required int petId,
      required int idddd}) async {
    Map<String, dynamic> bodyy = {
      "petId": petId,
      "id": idddd,
      "eventName": name,
      //"eventType":"LEt Plays",
      // "eventCategory":2,
      "eventDate": time
    };

    updateLoader(true);
    await api.editEventApi(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        // await callGetEvents();
        for (var item in eventList) {
          if (item.id == selectedEvent?.id) {
            selectedEvent = item;
          }
        }
        notifyListeners();

        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  Future locationListCall(BuildContext context) async {
    MapProvider mapProvider = Provider.of(context, listen: false);
    Map<String, dynamic> bodyy = {
      "petId": selectedPetDetail?.id ?? 0,
      "pageSize": 10,
      "pageIndex": 1,
    };
    updateLoader(true);
    await api.petlocation(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        List data = value.data["localtionList"] ?? [];
        locationList =
            data.map((e) => LocationListDetails.fromjson(e)).toList();
        print("location list length ${locationList.length}");
        mapProvider.addMarker(context);

        // CoolAlert.show(
        //     context: context, type: CoolAlertType.success, text: value.message);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  int? selectedPetIdForProtction;

  showGreenTickPro(int id) {
    Future.delayed(Duration.zero, () async {
      selectedPetIdForProtction = id;
      print("selectedPetIdForProtction===>> ${selectedPetIdForProtction}");
      notifyListeners();
    });
  }

  int? selectedPetIdShield;

  showGreenTickShield(int id) {
    Future.delayed(Duration.zero, () async {
      selectedPetIdShield = id;
      print("selectedPetIdShield===>> ${selectedPetIdShield}");
      notifyListeners();
    });
  }

  int SheildList = 0;

  showSheildList(int indx) {
    Future.delayed(Duration.zero, () async {
      SheildList = indx;
      print("SheildList===>> ${SheildList}");
      notifyListeners();
    });
  }

  int isShowAgain = 0;

  checkShowAgain() {
    Future.delayed(Duration.zero, () async {
      isShowAgain = 1;
      print("isShowAgain===>> ${isShowAgain}");
      notifyListeners();
    });
  }

  int? selectedWeightCont;

  showContBorder(int id) {
    Future.delayed(Duration.zero, () async {
      selectedWeightCont = id;
      notifyListeners();
    });
  }

  var selectedPetId;

  int? selectedPetIdForEvent;

  showGreenTick(int id) {
    Future.delayed(Duration.zero, () async {
      selectedPetIdForEvent = id;
      notifyListeners();
    });
  }

  int? selectedPetIdForNotes;

  displayGreenTick(int id) {
    Future.delayed(Duration.zero, () async {
      selectedPetIdForNotes = id;

      notifyListeners();
    });
  }

  int? selectedNotesButton;

  showBlueButton(int id) {
    Future.delayed(Duration.zero, () async {
      selectedNotesButton = id;
      notifyListeners();
    });
  }

  int? petFilterId;

  showinGreenTick(int id) {
    Future.delayed(Duration.zero, () async {
      petFilterId = id;
      notifyListeners();
    });
  }

  List<int> greenTickList = [];

  var petIdForEdit;

  setPetIdFroEditEvent(int petEditId) {
    Future.delayed(Duration.zero, () async {
      petIdForEdit = petEditId;
      print("petIdForEdit===>> ${petIdForEdit}");
      notifyListeners();
    });
  }

  void updateQrCodeSreen() {
    notifyListeners();
  }

  ///p2----------------------------------------------------

  var cateId;
  setDocCateId(int val) {
    cateId = val;
    notifyListeners();
  }

  String docCateName = "";
  setDocCateName(int val) {
    String? s1;
    switch (val) {
      case 1:
        s1 = "Vet Visits Category";
        break;

      case 2:
        s1 = "Invoices Category";
        break;

      case 3:
        s1 = "Vaccinations Category";
        break;

      case 4:
        s1 = "Lab Tests Category";
        break;

      case 5:
        s1 = "Business Cards Category";
        break;

      case 6:
        s1 = "Agreements Category";
        break;

      case 7:
        s1 = "Certificates Category";
        break;

      case 8:
        s1 = "Passports Category";
        break;

      case 9:
        s1 = "Pedigree Category";
        break;

      case 10:
        s1 = "Others Category";
        break;
    }

    docCateName = s1!;
    notifyListeners();
  }

  List<Msnger> msgList = [];

  int? msngrType;
  setMesngrType(int val) {
    msngrType = val;
    setMsngrVal(val);
    print("value of mgs type=====> ${msngrType}");
    print("value of mgs name=====> ${MesngrTxt}");
    print("value of mgs list=====> ${msgList}");
    notifyListeners();
  }

  String? MesngrTxt;

  setMsngrVal(int val) {
    switch (val) {
      case 1:
        MesngrTxt = "Telegram";
        msgList.add(Msnger(MsngrName: MesngrTxt, MengrType: 1));
        break;

      case 2:
        MesngrTxt = "Whatsapp";
        msgList.add(Msnger(MsngrName: MesngrTxt, MengrType: 2));
        break;

      case 3:
        MesngrTxt = "Facebook Messenger";
        msgList.add(Msnger(MsngrName: MesngrTxt, MengrType: 3));
        break;

      case 4:
        MesngrTxt = "Viber";
        msgList.add(Msnger(MsngrName: MesngrTxt, MengrType: 4));
        break;

      case 5:
        MesngrTxt = "Other Number";
        msgList.add(Msnger(MsngrName: MesngrTxt, MengrType: 5));
        break;
    }
  }

  onselectMgnr(PetTypeModl val) {
    selectedMsngrType = val;
    notifyListeners();
  }

  List<int> MsngrLst = [];
  List<int> xtrFeatureLst = [];
  int addMsngrNum = 0;

  MsngrNums() {
    addMsngrNum = addMsngrNum + 1;
    MsngrLst.add(1);
    print("======list length===>>> ${MsngrLst}");
    print("=========>>> ${addMsngrNum}");
    notifyListeners();
  }

  int addFechr = 0;

  FechrNums() {
    addFechr = addFechr + 1;
    xtrFeatureLst.add(1);
    print("======list length===>>> ${xtrFeatureLst}");
    print("=========>>> ${addFechr}");
    notifyListeners();
  }

  // GetDocV2() async {
  //   updateLoader(true);
  //   updateLoaderListen(true);
  //   await api.getDocumentsApi({
  //     "petId": selectedPetDetail?.id ?? "",
  //     "catagoriesId": cateId
  //   }).then((value) {
  //     updateLoader(false);
  //     updateLoaderListen(false);
  //     if (value.status == Status.success) {
  //       documentList.clear();
  //       List temp = value.data["catagoriesList"] ?? [];
  //       documentList = temp.map((e) => DocumentDetails.fromjson(e)).toList();
  //     } else {
  //       documentList = [];
  //     }
  //     notifyListeners();
  //   });
  // }

  GetDocV2() async {
    updateLoader(true);
    updateLoaderListen(true);

    await api.getDocumentsApi({
      "petId": selectedPetDetail?.id ?? "",
      "catagoriesId": cateId
    }).then((value) {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        TotaldocumentList.clear();
        documentList.clear();
        List temp = value.data["documents"] ?? [];
        documentList = temp.map((e) => DocumentDetails.fromjson(e)).toList();
        // documentListV2=temp.map((e) => DocumentDetailsV2.fromjson(e)).toList();
        print("documentList=====${documentList.length}");
        // print("documentListV2=====${documentListV2.length}");
      } else {
        documentList = [];
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  Future callVerifiedList() async {
    await api.verifiedList().then((value) {
      if (value.status == Status.success) {
        verifiedListApiModel = VerifiedListApiModel.fromJson(value.data);
        print(
            "verifiedListApiModel length ${verifiedListApiModel?.verifiedList.length ?? 0}");
        print(
            "notVerified length ${verifiedListApiModel?.notVerified.length ?? 0}");
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  /// Future calleuestFunction(){
  // Future callRequestFunction() async {
  //   await api.verifiedRequest(8, 1).then((value) {
  //     if (value.status == Status.success) {
  //       showToast(value.message);
  //     }
  //   });
  // }

  callAddDocumentV2(
      {required String doctitle,
      required String docDate,
      required BuildContext context,
      int? filetype}) async {
    if (docFile != null) {
      List images = [
        {"key": "image", "image": docFile}
      ];
      updateLoader(true);
      await api.callUploadPetImage(true, images).then((value) async {
        if (value.status == Status.success) {
          print("IMAGE OR FILEE NAMEE ${value.data["fileName"]}");
          String filee = value.data["fileName"];
          Map<String, dynamic> bodyy = {
            "petId": selectedPetDetail?.id ?? "",
            "documentUrl": filee,
            "catagoryId": selectedDocType?.typeId,
            "title": doctitle,
            "isUsedDate": docDate,
            "fileType": filetype,
          };
          print("REQUESTTT $bodyy");
          await api.addNewDocV2(bodyy).then((value) async {
            updateLoader(false);
            if (value.status == Status.success) {
              await GetDocV2();
              // await callGetDoc();

              print("djkdfkdjgkjd");

            await CoolAlert.show(
                  context: GlobalVariable.navState.currentContext!,
                  type: CoolAlertType.success,
                  text: value.message);

              Navigator.pop(context);

              // Future.delayed(const Duration(milliseconds: 400), () {
              //    CoolAlert.show(
              //       context: context,
              //       type: CoolAlertType.success,
              //       text: value.message);
              //
              //   Navigator.pop(context);
              // });
              print("djkdfkdjgkjd");

            } else {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: value.message);
            }
          }).onError((error, stackTrace) => updateLoader(false));
        } else {
          updateLoader(false);
        }
      });
      //.onError((error, stackTrace) => updateLoader(false));
    }
  }

  /// *************************************************

  Future EvntcateApiCall(BuildContext context,
      {bool isfromedit = false}) async {
    updateLoader(true);
    Map body = {};
    await api.masterEventApi(body).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        print("STATUSS${value.data}");
        List? eventsList = [];
        eventsList = value.data["events"];
        masterEventlList =
            eventsList!.map((e) => MasterEvent.fromJson(e)).toList();

        print("master detail list ${masterEventlList}");
        if (isfromedit) {
          // seleectedEvnt
          if (seleectedEvnt != null) {
            for (int i = 0; i < masterEventlList.length; i++) {
              if (masterEventlList[i].id == seleectedEvnt?.eventCategoryId) {
                updateSelectedEvntCate(masterEventlList[i]);
                if (masterEventlList[i].evtCatagoryList.isNotEmpty) {
                  for (int j = 0;
                      j < masterEventlList[i].evtCatagoryList.length;
                      j++) {
                    if (seleectedEvnt?.eventCategoryTypeId ==
                        masterEventlList[i].evtCatagoryList[j].id) {
                      selectedSubEvnt = masterEventlList[i].evtCatagoryList[j];
                    }
                  }
                }
              }
            }
          }
        } else {
          updateSelectedEvntCate(masterEventlList.first);
        }
      }
      // notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  ///**************************************************

  EvntCatagoryList? selectedSubEvnt;

  CatagoryList? selectedSubCategory;
  MasterDetails? selectedMasterCategory;
  List<MasterDetails> masterDetailList = [];
  List<MasterEvent> masterEventlList = [];

  MasterEvent? seletedMaterEvnt;

  // EvntCatagoryList? selectedEvntSubCate;

  cateTypeApiCall(BuildContext context, {bool isfromedit = false}) async {
    updateLoader(true);
    Map body = {};
    await api.masterListApi(body).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        print("STATUSS${value.data}");

        List notesList = value.data["notesList"];
        masterDetailList =
            notesList.map((e) => MasterDetails.fromJson(e)).toList();

        print("master detail list ${masterDetailList}");
        if (isfromedit) {
          if (selectedNotes != null) {
            for (int i = 0; i < masterDetailList.length; i++) {
              if (masterDetailList[i].id == selectedNotes?.notesCatagoriesId) {
                updateSelectedCategory(masterDetailList[i]);
                if (masterDetailList[i].catagoryList.isNotEmpty) {
                  for (int j = 0;
                      j < masterDetailList[i].catagoryList.length;
                      j++) {
                    if (selectedNotes?.notesTypesCatagoriesId ==
                        masterDetailList[i].catagoryList[j].id) {
                      selectedSubCategory = masterDetailList[i].catagoryList[j];
                    }
                  }
                }
              }
            }
          }
        } else {
          updateSelectedCategory(masterDetailList.first);
        }
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  updateSelectedCategory(MasterDetails detail) {
    selectedMasterCategory = detail;

    notifyListeners();
  }

  updateSelectedCat(MasterDetails detail) {
    selectedMasterCategory = detail;
    // selectedMasterCategory?.buttonisSelected=true;
    notifyListeners();
  }

  updateSelectedEvntCate(MasterEvent detail) {
    seletedMaterEvnt = detail;

    notifyListeners();
  }

  List notesimages = [];

  callAddNotes({
    required BuildContext context,
    required int pettidd,
    required int cateId,
    required int cateTypeId,
    required int reaction,
    required String title,
    required String drug,
  }) async {
    if (notesFile.isNotEmpty) {
      // notesimages.clear();
      print("=====notesfile=addnote  = ${notesimages.length}");
      for (int i = 0; i < notesFile.length; i++) {
        List images = [
          {"key": "image", "image": notesFile[i]}
        ];
        await api.callUploadPetImage(true, images).then((value) async {
          if (value.status == Status.success) {
            print("IMAGE OR FILEE NAMEE ${value.data["fileName"]}");
            String filee = value.data["fileName"];
            notesimages.add({"url": filee});
          }
        });
      }
    }

    Map<String, dynamic> bodyy = {
      "petId": pettidd,
      "categoriesId": cateId,
      "catagoriesTypesId": cateTypeId,
      "title": title,
      "drug": drug,
      "reaction": reaction,
      "image": notesimages
    };
    print("+++___>>>>> ${bodyy}");
    updateLoader(true);
    await api.addNotesApi(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        await callGetNotes();
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pop(context);
      } else {
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

// List

  String petIdList = "";



  callGetNotes() async {
    updateLoader(true);
    updateLoaderListen(true);
    await api.getPetNotesApi({
      "petId": petIdList,
    }).then((value) {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        // petIdList="";
        print("pet id after api call====>> ${petIdList}");
        notesList.clear();
        List temp = value.data["NotesDetails"] ?? [];
        notesList = temp.map((e) => NotesDetails.fromJson(e)).toList();
      } else {
        notesList = [];
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  int permPetCount=0;
  int premCnt=0;

  // callPetPremDetails() async {
  //   updateLoader(true);
  //   updateLoaderListen(true);
  //   premCnt=0;
  //   await api.getPetPremDetails().then((value) async {
  //     updateLoader(false);
  //     updateLoaderListen(false);
  //     if (value.status == Status.success) {
  //     print("===petPremiumCount==${value.data["petPremiumCount"]}");
  //     permPetCount=value.data["petPremiumCount"];
  //
  //     if(permPetCount>=4){
  //       premCnt=1;
  //       print("premCnt===>>${premCnt}");
  //       await CoolAlert.show(
  //           context: GlobalVariable.navState.currentContext!, type: CoolAlertType.error, text: "You have already activated premium feature for 4 pets");
  //     }
  //     print("premCnt===>>${premCnt}");
  //     notifyListeners();
  //    //permPetCount
  //     } else {
  //       return;
  //     }
  //     notifyListeners();
  //   }).onError((error, stackTrace) => updateLoader(false));
  // }
   int noMorePrem=0;
  int permPetCountAddPet=0;
 callPetPremDetailsAddPet() async {
    updateLoader(true);
    updateLoaderListen(true);

    await api.getPetPremDetails().then((value) async {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
      print("===petPremiumCount==${value.data["petPremiumCount"]}");
      permPetCountAddPet=value.data["petPremiumCount"];
      print("premCnt===>>${permPetCountAddPet}");
      if(permPetCountAddPet==4 || permPetCountAddPet>4){
        noMorePrem=1;

        return;
      }


      notifyListeners();

      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  deleteNotesApiCall({
    required BuildContext context,
    required int idddd,
  }) async {
    updateLoader(true);
    await api.deleteNotesApi({"id": idddd}).then((value) async {
      if (value.status == Status.success) {
        updateLoader(false);
        await callGetNotes();
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pop(context);
      } else {
        updateLoader(false);
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  addEventP2ApiCall(
      {required BuildContext context,
      required String start,
      required String end,
      required String name,
      required int pettidd,
      required int evntCateid,
      required int evntCateType,
      required bool fromPet}) async {
    if (remindType == null) {
      remindType = 0;
    }
    Map<String, dynamic> bodyy = {
      "petId": pettidd,
      "eventCatagoryId": evntCateid,
      "eventCatagoryTypeId": evntCateType,
      "eventStartDate": start,
      "eventEndDate": end,
      "isRepeat": repeatType,
      "isRemendirBefore": remindType,
      "eventName": name
    };

    int m1 = getMonth(start);
    int y1 = getYear(start);

    updateLoader(true);
    await api.addEventP2Api(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        print("month ::: ${m1}");
        print("year ::: ${y1}");

        print("is from pet===>>${fromPet}");
        await callgetPetEventP2(m1, y1, fromPet);
        if (valDate != null) {
          await filterData(valDate!);
        }
        print("api call");
        print("pet imageeeee ${value.data["petPhoto"]}");
        print("pet nameee ${value.data["petName"]}");
        eventpetname = value.data["petName"];
        eventpetphoto = value.data["petPhoto"];
        // await callGetEvents();
        // for (var item in eventList) {
        //   if (item.id == selectedEvent?.id) {
        //     selectedEvent = item;
        //   }
        // }

        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pop(context);
      } else {
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) {
      updateLoader(false);
      print("erroe msg===>> ${error}");
    });
  }

  DateTime focusedDayyPP = DateTime.now();

  editEventP2ApiCall(
      {required BuildContext context,
      required String start,
      required String end,
      required int idd,
      required String name,
      required int pettidd,
      required int evntCateid,
      required int evntCateType,
      required bool frompet}) async {
    Map<String, dynamic> bodyy = {
      "petId": pettidd,
      "id": idd,
      "eventCatagoryId": evntCateid,
      "eventCatagoryTypeId": evntCateType,
      "eventStartDate": start,
      "eventEndDate": end,
      "isRepeat": repeatType,
      "isRemendirBefore": remindType,
      "eventName": name
    };

    int m1 = getMonth(start);
    int y1 = getYear(start);

    updateLoader(true);
    await api.editEventP2Api(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        print("from pet==>>${frompet}");
        await callgetPetEventP2(m1, y1, frompet);
        if (valDate != null) {
          await filterData(valDate!);
        }
        // getEventsfromDay(DateTime.now());
        for (var item in eventP2List) {
          if (item.id == seleectedEvnt?.id) {
            seleectedEvnt = item;
          }
        }
        notifyListeners();

        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        // Navigator.pushNamedAndRemoveUntil(context, AppScreen.eventcalender, (r) => false);
        focusedDayyPP = DateTime.now();
        print("focusedDayyPP${focusedDayyPP}");
        Navigator.pop(context);
        Navigator.pop(context);
        await callgetPetEventP2(m1, y1, frompet);
      } else {
        updateLoader(false);
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) {
      updateLoader(false);
      print("error==>>${error}");
    });
  }

  List notesPhoto = [];

  callEditNotes({
    required BuildContext context,
    required int pettidd,
    required int idd,
    required int cateId,
    required int cateTypeId,
    required int reaction,
    required String title,
    required String drug,
  }) async {
    if (editNoteList.isNotEmpty) {
      notesPhoto.clear();
      print("=====notesfile=editnote  = ${editNoteList.length}");
      for (int i = 0; i < editNoteList.length; i++) {
        List images = [];
        // type 1 = url string  type 2 file1
        if (editNoteList[i].type == 1) {
          notesPhoto.add({"url": editNoteList[i].Imgurl});
        } else {
          images = [
            {"key": "image", "image": editNoteList[i].file1}
          ];
          await api.callUploadPetImage(true, images).then((value) async {
            if (value.status == Status.success) {
              print("IMAGE OR FILEE NAMEE ${value.data["fileName"]}");
              String filee = value.data["fileName"];
              notesPhoto.add({"url": filee});
            }
          });
        }
      }
      print("final photo list== ${notesPhoto}");
    }
    Map<String, dynamic> bodyy = {
      "petId": pettidd,
      "id": idd,
      "categoriesId": cateId,
      "catagoriesTypesId": cateTypeId,
      "title": title,
      "drug": drug,
      "reaction": reaction,
      "image": notesPhoto
    };
    print("+++___>>>>> ${bodyy}");
    updateLoader(true);
    await api.editNotesApi(bodyy).then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        await callGetNotes();
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Notes()));
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  List<FlSpot> ConstGraphData = [
    FlSpot(0.5, 40),
  ];

  List<FlSpot> graphSpotData = [];
  double x = 0;
  setSpotData() {
    List lst = weightList.map((e) => (e).weight).toList();
    print("*********** ${lst}");

    graphSpotData = lst.map((e) => FlSpot(x++, e)).toList();
    print("****************** ${graphSpotData}");

    notifyListeners();
  }

  var healthyWeight;
  void fromHealthyWeight(String str1) {
    healthyWeight = str1;
    print("healthy weight==== ${healthyWeight}");
    notifyListeners();
  }

  var priorWeight;

  void frompriorWeight(String str2) {
    priorWeight = str2;
    print("priorWeight==== ${priorWeight}");
    notifyListeners();
  }

  List<FlSpot> healthyGraphData = [];

  void setHealthyWeightLine() {
    double p = 0;

    List lst = weightList.map((e) => (e).weight).toList();
    print("*********** ${lst}");

    double dt = double.parse(petHealtweightCntrolr.text);
    healthyGraphData = lst.map((e) => FlSpot(p++, dt)).toList();
    print("healthyGraphDatahealthyGraphData ${healthyGraphData}");
  }

  void setChangeWeight(WeightDetails weightData, int indx, double hltyWeight) {
    print("is healthy weight value set check===>> ${hltyWeight}");

    print("print weight===>> ${weightList[indx].weight}");
    var wght = weightList[indx].weight;

    var vr1 = wght! - hltyWeight;
    print("set change weight check======>>>>  ${vr1.toStringAsFixed(2)}");

    fromHealthyWeight(vr1.toStringAsFixed(2));

    //prior weight
    var vr3;
    if (indx == weightList.length - 1) {
      vr3 = 0.0;
    } else {
      var vr4 = indx + 1;
      vr3 = weightList[vr4].weight;
    }
    var curWeight = weightList[indx].weight;
    var weighthfinal = curWeight! - vr3;
    frompriorWeight(weighthfinal.toStringAsFixed(2));

//prior weight
  }

  bool isChangeData = false;

  void isCheckNext(WeightDetails weightData, int indx, double hltyWeight) {
    isChangeData = true;
    print("value of isChangedDatat==== >>> ${isChangeData}");
    Future.delayed(Duration(milliseconds: 100), () {
      print("######################################");
      // isChangeData?setChangeWeight(weightData,indx,hltyWeight):SizedBox();
      if (isChangeData) {
        setChangeWeight(weightData, indx, hltyWeight);
      }
      isChangeData = false;
      print("######################################>> ${isChangeData}");
      weightPetDate = dateConverter(int.parse(weightData.date ?? ""));
      weightPetWeight = weightData.weight ?? 0.0;
      weightPetDesc = weightData.description ?? "";
      petweightCntrolr.text = weightData.description ?? "";
      print(
          "######################################>> ${petweightCntrolr.text}");
      // petweightCntrolr=

      notifyListeners();
    }).onError((error, stackTrace) {
      print("errroe found==>>> ${error}");
    });
  }

  var weightPetDate = "";
  var weightPetWeight = 0.0;
  var weightPetDesc = "";

  void removeNotesFile() {
    print("function called ${notesFile.length}");
    print("function called");
    notesFile.clear();
    // notesFile.removeAt(index)
    notifyListeners();
    print("function called ${notesFile.length}");
  }

  var hlWtfrmapi;

  var showSaveButon;

  callGetWeight() async {
    updateLoader(true);

    await api
        .getWeightApi({"petId": selectedPetDetail?.id ?? ""}).then((value) {
      updateLoader(false);

      if (value.status == Status.success) {
        weightList.clear();

        print("value of healthy weight===>>> ${value.data["healthyWeight"]}");

        if(value.data["healthyWeight"]==null){
          value.data["healthyWeight"]=0.0;
        }

        hlWtfrmapi = value.data["healthyWeight"];

        print(
            "valuue dot data dot hea;thy weight==<${value.data["healthyWeight"]}");

        if (value.data["healthyWeight"] == 0) {
          showSaveButon = 1;
        } else {
          showSaveButon = 0;
        }

        print("value of healthy weight===>>> ${value.data["healthyWeight"]}");

        hlWtfrmapi = value.data["healthyWeight"];

        print(
            "valuue dot data dot hea;thy weight==<${value.data["healthyWeight"]}");

        if (value.data["healthyWeight"] == 0) {
          showSaveButon = 1;
        } else {
          showSaveButon = 0;
        }

        List temp = value.data["weightList"] ?? [];
        weightList = temp.map((e) => WeightDetails.fromjson(e)).toList();
        print("printing weight list=== ${weightList}");

        petHealtweightCntrolr.text = hlWtfrmapi.toString();

        if (weightList.isNotEmpty) {
          showContBorder(weightList[0].id ?? 0);

          print("disc of weight provi==>> ${weightList[0].description!}");

          petweightCntrolr.text = weightList[0].description!;

          weightPetWeight = weightList[0].weight!;

          weightPetDate = dateConverter(int.parse(weightList[0].date!));
          print("date set provider===>>${weightPetDate}");

          print(
              "invalid double error==>> ${double.parse(petHealtweightCntrolr.text)}");

          setChangeWeight(
              weightList[0], 0, double.parse(petHealtweightCntrolr.text));
        } else {
          petweightCntrolr.text = "No weight entry found.";
          healthyWeight = "0.0";
          priorWeight = "0.0";

          weightPetDate = dateConverter(
              int.parse(DateTime.now().millisecondsSinceEpoch.toString()));
        }

        x = 0;
        setSpotData();
        setHealthyWeightLine();
        notifyListeners();
      } else {
        weightList = [];
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  callAddWeight({
    required BuildContext context,
    required String weight,
    required String wtDate,
    required String wtDesc,
  }) async {
    updateLoader(true);
    updateLoaderListen(true);
    await api.addWeightApi({
      "petId": selectedPetDetail?.id ?? "",
      "weight": weight,
      "date": wtDate,
      "description": wtDesc,
    }).then((value) async {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        callGetWeight();
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        Navigator.pop(context);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  late TabController tabController;
  setTabController(cont) {
    tabController = cont;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  navigateByTabController(int indx) {
    tabController.index = indx;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  callAddPetHealthApi({
    required BuildContext context,
    required String vacination,
    required String weight,
    required String allergies,
    required String treatment,
  }) async {
    updateLoader(true);
    updateLoaderListen(true);
    await api.addPetHealthApi({
      "petId": selectedPetDetail?.id ?? "",
      "vaccination": vacination,
      "weight": weight,
      "allergies": allergies,
      "treatment": treatment
    }).then((value) async {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        await CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Health Card is added");

        navigateByTabController(1);

        // // Navigator.pop(context);
        //
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewHealthCard(val: 1,)));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HealthCard()));
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  callEditPetHealthApi({
    required BuildContext context,
    required int iddd,
    required String vacination,
    required double weight,
    required String allergies,
    required String treatment,
  }) async {
    updateLoader(true);

    await api.editPetHealthApi({
      "id": iddd,
      "vaccination": vacination,
      "weight": weight,
      "allergies": allergies,
      "treatment": treatment
    }).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        callGetAllPetHealthApi(context);
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        Navigator.pop(context);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
        updateLoader(false);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  var healthCardId;
  setCardID(int val) {
    healthCardId = val;
  }

  callDeletePetHealthApi({
    required BuildContext context,
    required int idddd,
  }) async {
    updateLoader(true);
    await api.deletePetHealthApi({"id": idddd}).then((value) async {
      if (value.status == Status.success) {
        updateLoader(false);
        await callGetAllPetHealthApi(context);
        await CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Health Card is deleted");
        Navigator.pop(context);
      } else {
        updateLoader(false);
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) {
      updateLoader(false);
      print("rerror===>> ${error}");
    });
  }

  var pdfUrl;

  var dataurl;

  Map<String, dynamic> downloadMap = {};

  callDownloadProfileApi({required BuildContext context}) async {
    updateLoader(true);

    var url = Uri.parse("");
    // var response =Uri
    await api.downloadProfileApi({"petId": selectedPetDetail?.id ?? 0}).then(
        (value) async {
      if (value.status == Status.success) {
        dataurl = value.data;
        print("");
        updateLoader(false);

        Navigator.pop(context);
      } else {
        updateLoader(false);
      }
    }).onError((error, stackTrace) => updateLoader(false));
  }

  List<HealthCard> PetallHlthCard = [];

  callGetAllPetHealthApi(
    BuildContext context,
  ) async {
    updateLoader(true);
    updateLoaderListen(true);
    await api.getAllPetHealthApi({
      "petId": selectedPetDetail?.id ?? "",
    }).then((value) async {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        print("value of status${value.status}");

        PetallHlthCard.clear();
        List temp = value.data["PetAllHealth"];
        PetallHlthCard = temp.map((e) => HealthCard.fromJson(e)).toList();
        print("value in list===>>> ${PetallHlthCard}");
      } else {
        PetallHlthCard = [];
        // CoolAlert.show(context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  var insta;
  var whatsap;
  var iMsgNo;
  var WsapphCode;
  var finalNum;

  var logo;

  contactUsApiCall(BuildContext context) async {
    // updateLoader(true);
    Map body = {};
    await api.contactUsApi().then((value) async {
      updateLoader(false);
      if (value.status == Status.success) {
        print("numper =>${value.data["phoneNumber"]}");
        print("instagram =>${value.data["instagram"]}");
        insta = value.data["instagram"];
        whatsap = value.data["phoneNumber"];
        iMsgNo = value.data["apple"];
        WsapphCode = value.data["phoneCode"];
        finalNum = WsapphCode + " " + whatsap;
        print("final insta nuber===${insta}=====");
        print("final whatsapp nuber===${finalNum}");
        print("final iMsgNo iMsgNo===${iMsgNo}");

        print("logo url====${value.data["logo"]}");
        logo = value.data["logo"];
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  // edit weight

  callEditWeight({
    required BuildContext context,
    required String weight,
    required String wtDate,
    required String wtDesc,
    required int recId,
  }) async {
    updateLoader(true);
    updateLoaderListen(true);
    await api.editWeightApi({
      "petId": selectedPetDetail?.id ?? "",
      "weight": weight,
      "date": wtDate,
      "description": wtDesc,
      "id": recId
    }).then((value) async {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        callGetWeight();
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        Navigator.pop(context);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  deleteWeightApiCall({
    required BuildContext context,
    required int idddd,
  }) async {
    updateLoader(true);
    await api.deleteWeightApi({"id": idddd}).then((value) async {
      if (value.status == Status.success) {
        updateLoader(false);
        await callGetWeight();
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);
        Navigator.pop(context);
      } else {
        updateLoader(false);
        await CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
    }).onError((error, stackTrace) {
      updateLoader(false);

      print("rererer weight=== >${error}");
    });
  }


  MakePetPremium() async {
    updateLoader(true);
    await api.setPetPremApi(
        {
          "petId":selectedPetDetail?.id ?? "",
          "status": 1
        }
    ).then((value) async {
if (value.status == Status.success) {

selectedPetDetail?.isPremium=1;

print("api successsssssss");
updateLoader(false);
Future.delayed(const Duration(milliseconds: 400), () async {
await getAllPet();
});
print("api enddddd======");
}else{

  print("condition false::::;;");
  print("pet id of pet::::${ selectedPetDetail?.id}");
  selectedPetDetail?.isPremium=0;
  await getAllPet();
updateLoader(false);
pet4Prem=1;
print("pet4Prem====pet4Prem==-> ${pet4Prem}");

notifyListeners();

await CoolAlert.show(
context: GlobalVariable.navState.currentContext!, type: CoolAlertType.error, text: value.message).then((value) async {
  // changePetPremVal();
   selectedPetDetail?.isPremium=0;
   await getAllPet();
   print("setselectedPetId:::::${setselectedPetId}");
   for(int i=0;i<petDetailList.length;i++){
     print("list ids:::::${petDetailList[i].id}");

     if(petDetailList[i].id==setselectedPetId){
       print("this is trueee::;");
       petDetailList[i].isPremium=0;
       print("petDetailList[i].isPremium:::${petDetailList[i].isPremium}");
       notifyListeners();
     }
     print("prem val of all pets::::${petDetailList[i].isPremium}");
   }

});
// Navigator.pop(GlobalVariable.navState.currentContext!);
return;

}
}).onError((error, stackTrace) {
updateLoader(false);

});
    // await api.deleteWeightApi({"id": idddd}).then((value) async {
    //   if (value.status == Status.success) {
    //     updateLoader(false);
    //     await callGetWeight();
    //     await CoolAlert.show(
    //         context: context, type: CoolAlertType.success, text: value.message);
    //     Navigator.pop(context);
    //   } else {
    //     updateLoader(false);
    //     await CoolAlert.show(
    //         context: context, type: CoolAlertType.error, text: value.message);
    //   }
    // }).onError((error, stackTrace) {
    //   updateLoader(false);
    //
    //   print("rererer weight=== >${error}");
    // });
  }







  int pet4Prem=0;

  setPetPremApiCall() async {
    pet4Prem=0;
    updateLoader(true);


    // callPetPremDetails();
    print("this is callinnngggngngng");
    await callPetPremDetailsAddPet();

    print("this is calleddddddd");
    print("permPetCountAddPet:::::::::::::::${permPetCountAddPet}");

    if(premCnt==1){
      return;
    }
    print("isPremium====${selectedPetDetail?.isPremium}");
    print("valChange==1====${valChange}");

    if(selectedPetDetail?.isPremium==1 && valChange==0){
      return;
    }



    int stat=0;
    if(valChange==1){
      stat=PetStatusval;
    }else{
      stat=selectedPetDetail?.isPremium??0;
    }
    print("stat====${stat}");



    await api.setPetPremApi(
    {
    "petId":selectedPetDetail?.id ?? "",
    "status": stat
    }
    ).then((value) async {
      if (value.status == Status.success) {
       if(stat==1){
        selectedPetDetail?.isPremium=1;
       }
        print("api successsssssss");
        updateLoader(false);
        Future.delayed(const Duration(milliseconds: 400), () async {
          await getAllPet();
        });
        print("api enddddd======");
       }else{
        print("hereeeeee:::::::::::::::::::::::::::::::::::::");
        selectedPetDetail?.isPremium=0;
        // await getAllPet();
        updateLoader(false);
          pet4Prem=1;
          print("pet4Prem====pet4Prem==-> ${pet4Prem}");

          notifyListeners();

         CoolAlert.show(
            context: GlobalVariable.navState.currentContext!, type: CoolAlertType.error, text: value.message).then((value) async {

         selectedPetDetail?.isPremium=0;
         print(" selectedPetDetail?.isPremium${ selectedPetDetail?.isPremium}");
         notifyListeners();
         await getAllPet();
         for(int i=0;i<petDetailList.length;i++){
           if(petDetailList[i].id==setselectedPetId){
             print("this condition is true");
             petDetailList[i].isPremium=0;
           }
           print("prem val of all pets::::${petDetailList[i].isPremium}");
         }
         notifyListeners();
         });
              return;
      }
    }).onError((error, stackTrace) {
      updateLoader(false);

    });
  }

  List tagNumLst = [];

  callGetQrTag() async {
    updateLoader(true);
    updateLoaderListen(true);
    await api.getAllQrTag({
      "petId": selectedPetDetail?.id ?? "",
    }).then((value) {
      updateLoader(false);
      updateLoaderListen(false);
      if (value.status == Status.success) {
        tagNumLst.clear();
        qrTagList.clear();
        List temp = value.data["Pets"] ?? [];
        qrTagList = temp.map((e) => TagDetails.fromjson(e)).toList();

        for (int i = 0; i < qrTagList.length; i++) {
          tagNumLst.add(qrTagList[i].qrTagNumber);
        }

        print("list containing all the tag numbers===> ${tagNumLst}");
      } else {
        qrTagList = [];
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  callEditProtection({
    required BuildContext context,
    required String petMicrochip,
    required List PetIdentfies,
    required List messengers,
    required List mobNumLst,
  }) async {
    updateLoader(true);

    await api.editProtectionApi({
      "microChip": petMicrochip,
      "PetIdentfies": PetIdentfies,
      "messengers": messengers,
      "mobileNumber": mobNumLst,
      "petId": selectedPetIdForProtction,
    }).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        Navigator.pop(context);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  callRequestManagement({
    required BuildContext context,
    required name,
    required email,
  }) async {
    updateLoader(true);

    await api.requestManagementApi({}).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        await CoolAlert.show(
            context: context, type: CoolAlertType.success, text: value.message);

        Navigator.pop(context);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  int isUpdate = 0;
  String healthyWghtValSet = "";

  callEditHealthyPetWeight({
    required BuildContext context,
    required String healthyWeight,
    required int isUpdateeee,
  }) async {
    updateLoader(true);

    await api.editHealthyPetWeightApi({
      "petId": setselectedPetId,
      "healthyWeight": healthyWeight,
      "isUpdate": isUpdateeee,
    }).then((value) async {
      updateLoader(false);

      if (value.status == Status.success) {
        var data = value.data;
        print("data==healthy pet weight=>> ${data}");
        print(
            "data==healthy pet weight healthWeight key val =>> ${data["healthWeight"]}");
        healthyWghtValSet = data["healthWeight"].toString();

        EasyLoading.showToast("Success",
            toastPosition: EasyLoadingToastPosition.center);
      } else {
        CoolAlert.show(
            context: context, type: CoolAlertType.error, text: value.message);
      }
      notifyListeners();
    }).onError((error, stackTrace) => updateLoader(false));
  }

  List<MasterEvent> evtDetailList = [];

  setProtectionFlagVals(int index, String code, String flag) {
    xtraPhNumlist[index].cntyCode = "+" + code;
    xtraPhNumlist[index].cntyflag = flag;

    notifyListeners();
  }

  List<petMessengerContact> petmes = [];
  List<PetExtraContacts> xtraCont = [];
  List<PetIdentifiers> petidtifr = [];
  Users? user1;

  ProtectionModel? user;
  callGetProt() async {
    updateLoader(true);

    await api
        .getProtctionApi({"petId": selectedPetIdForProtction}).then((value) {
      updateLoader(false);

      PetFraturelist.clear();
      xtraContactlist.clear();
      xtraPhNumlist.clear();
      user = value;

      print("==microchipedit======${user?.users?.microchip}");
      // value.
      petProtMchip.text = user?.users?.microchip ?? "";

      xtraCont = value.petExtraContacts;
      if (xtraCont.isNotEmpty) {
        addNum = 1;
      } else {
        addNum = 0;
      }

      for (int j = 0; j < xtraCont.length; j++) {
        print("flag durinf api call==>${xtraCont[j].flag}");

        petProtFlag = "";
        TextEditingController tj = new TextEditingController();
        tj.text = xtraCont[j].mobileNumber.toString();
        print("phone code==>>> ${xtraCont[j].countryCode}");

        String s1 = xtraCont[j].countryCode ?? "";
        s1 = s1.replaceFirst("+", "");
        print("replace + sigh==>${(s1)}");

        xtraPhNumlist.add(xtraPhNumModel(
            cntyCode: xtraCont[j].countryCode,
            controller: tj,
            cntyflag: xtraCont[j].flag));
        notifyListeners();
      }

      petmes = value.petMessenger;
      if (petmes.isNotEmpty) {
        addMsngrNum = 1;
      } else {
        addMsngrNum = 0;
      }

      for (int i = 0; i < petmes.length; i++) {
        print("valuedata${petmes[i].name}");

        int? type = petmes[i].type;

        String title;
        switch (type) {
          case 1:
            title = "Telegram";
            break;

          case 2:
            title = "Whatsapp";
            break;

          case 3:
            title = "Facebook Messenger";
            break;

          case 4:
            title = "Viber";
            break;

          case 5:
            title = "Other Number";
            break;

          default:
            title = "Other Number";
            break;
        }

        TextEditingController ti = TextEditingController();
        ti.text = petmes[i].name.toString();

        xtraContactlist.add(ContactModel(
            controller: ti, num: petmes[i].type, xtraContact: title));
        print(
            "xtraContactlist=***=xtraContactlist${xtraContactlist[i].controller?.text}");
      }

      petidtifr = value.petIdentifiers;
      print("length of list${petidtifr.length}");

      if (petidtifr.isNotEmpty) {
        addFechr = 1;
      } else {
        addFechr = 0;
      }

      for (int i = 0; i < petidtifr.length; i++) {
        print("valuedata${petidtifr[i].name}");

        int? type = petidtifr[i].type;

        String title;

        switch (type) {
          case 1:
            title = "Special Feature";
            break;

          case 2:
            title = "Tattoos";
            break;

          case 3:
            title = "Clip";
            break;

          case 4:
            title = "Ring Number";
            break;

          case 5:
            title = "Internal Organization Number";
            break;

          case 6:
            title = "Account Number";
            break;

          case 7:
            title = "Breeding Book Number";
            break;

          case 8:
            title = "Other ID";
            break;

          default:
            title = "Other ID";
            break;
        }
        TextEditingController ti = TextEditingController();
        ti.text = petidtifr[i].name.toString();

        PetFraturelist.add(
            PetModel(controller: ti, type: petidtifr[i].type, SpFechr: title));

        print(
            "PetFraturelist=***=PetFraturelist${PetFraturelist[i].controller?.text}");
      }

      print("PetFraturelist==PetFraturelist${PetFraturelist}");
    }).onError((error, stackTrace) => loaderUpdate(false));

    notifyListeners();
  }

  var showRadioList;
  isShowRadioList(int val) {
    showRadioList = val;
    notifyListeners();
  }

  Repeat repeat = Repeat.never;

  RemindTime reTime = RemindTime.Min15;

  setRepeat(Repeat rpt) {
    Future.delayed(Duration.zero, () async {
      repeat = rpt;


      print("repeatt TimereTime===>> ${repeat}");
      notifyListeners();
    });
  }

  setReTime(RemindTime retme) {
    Future.delayed(Duration.zero, () async {
      reTime = retme;
      print("recuring TimereTime===>> ${reTime}");
      notifyListeners();
    });
  }

  String getContryFlag(
    String str,
  ) {
    final List<Map<String, dynamic>> countryCodes = [
      {
        "e164_cc": "93",
        "iso2_cc": "AF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Afghanistan",
        "example": "701234567",
        "display_name": "Afghanistan (AF) [+93]",
        "full_example_with_plus_sign": "+93701234567",
        "display_name_no_e164_cc": "Afghanistan (AF)",
        "e164_key": "93-AF-0"
      },
      {
        "e164_cc": "358",
        "iso2_cc": "AX",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "Åland Islands",
        "example": "412345678",
        "display_name": "Åland Islands (AX) [+358]",
        "full_example_with_plus_sign": "+358412345678",
        "display_name_no_e164_cc": "Åland Islands (AX)",
        "e164_key": "358-AX-0"
      },
      {
        "e164_cc": "355",
        "iso2_cc": "AL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Albania",
        "example": "661234567",
        "display_name": "Albania (AL) [+355]",
        "full_example_with_plus_sign": "+355661234567",
        "display_name_no_e164_cc": "Albania (AL)",
        "e164_key": "355-AL-0"
      },
      {
        "e164_cc": "213",
        "iso2_cc": "DZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Algeria",
        "example": "551234567",
        "display_name": "Algeria (DZ) [+213]",
        "full_example_with_plus_sign": "+213551234567",
        "display_name_no_e164_cc": "Algeria (DZ)",
        "e164_key": "213-DZ-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "AS",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "American Samoa",
        "example": "6847331234",
        "display_name": "American Samoa (AS) [+1]",
        "full_example_with_plus_sign": "+16847331234",
        "display_name_no_e164_cc": "American Samoa (AS)",
        "e164_key": "1-AS-0"
      },
      {
        "e164_cc": "376",
        "iso2_cc": "AD",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Andorra",
        "example": "312345",
        "display_name": "Andorra (AD) [+376]",
        "full_example_with_plus_sign": "+376312345",
        "display_name_no_e164_cc": "Andorra (AD)",
        "e164_key": "376-AD-0"
      },
      {
        "e164_cc": "244",
        "iso2_cc": "AO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Angola",
        "example": "923123456",
        "display_name": "Angola (AO) [+244]",
        "full_example_with_plus_sign": "+244923123456",
        "display_name_no_e164_cc": "Angola (AO)",
        "e164_key": "244-AO-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "AI",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Anguilla",
        "example": "2642351234",
        "display_name": "Anguilla (AI) [+1]",
        "full_example_with_plus_sign": "+12642351234",
        "display_name_no_e164_cc": "Anguilla (AI)",
        "e164_key": "1-AI-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "AG",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Antigua and Barbuda",
        "example": "2684641234",
        "display_name": "Antigua and Barbuda (AG) [+1]",
        "full_example_with_plus_sign": "+12684641234",
        "display_name_no_e164_cc": "Antigua and Barbuda (AG)",
        "e164_key": "1-AG-0"
      },
      {
        "e164_cc": "54",
        "iso2_cc": "AR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Argentina",
        "example": "91123456789",
        "display_name": "Argentina (AR) [+54]",
        "full_example_with_plus_sign": "+5491123456789",
        "display_name_no_e164_cc": "Argentina (AR)",
        "e164_key": "54-AR-0"
      },
      {
        "e164_cc": "374",
        "iso2_cc": "AM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Armenia",
        "example": "77123456",
        "display_name": "Armenia (AM) [+374]",
        "full_example_with_plus_sign": "+37477123456",
        "display_name_no_e164_cc": "Armenia (AM)",
        "e164_key": "374-AM-0"
      },
      {
        "e164_cc": "297",
        "iso2_cc": "AW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Aruba",
        "example": "5601234",
        "display_name": "Aruba (AW) [+297]",
        "full_example_with_plus_sign": "+2975601234",
        "display_name_no_e164_cc": "Aruba (AW)",
        "e164_key": "297-AW-0"
      },
      {
        "e164_cc": "247",
        "iso2_cc": "AC",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Ascension Island",
        "example": "",
        "display_name": "Ascension Island (AC) [+247]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Ascension Island (AC)",
        "e164_key": "247-AC-0"
      },
      {
        "e164_cc": "61",
        "iso2_cc": "AU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Australia",
        "example": "412345678",
        "display_name": "Australia (AU) [+61]",
        "full_example_with_plus_sign": "+61412345678",
        "display_name_no_e164_cc": "Australia (AU)",
        "e164_key": "61-AU-0"
      },
      {
        "e164_cc": "43",
        "iso2_cc": "AT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Austria",
        "example": "644123456",
        "display_name": "Austria (AT) [+43]",
        "full_example_with_plus_sign": "+43644123456",
        "display_name_no_e164_cc": "Austria (AT)",
        "e164_key": "43-AT-0"
      },
      {
        "e164_cc": "994",
        "iso2_cc": "AZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Azerbaijan",
        "example": "401234567",
        "display_name": "Azerbaijan (AZ) [+994]",
        "full_example_with_plus_sign": "+994401234567",
        "display_name_no_e164_cc": "Azerbaijan (AZ)",
        "e164_key": "994-AZ-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "BS",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Bahamas",
        "example": "2423591234",
        "display_name": "Bahamas (BS) [+1]",
        "full_example_with_plus_sign": "+12423591234",
        "display_name_no_e164_cc": "Bahamas (BS)",
        "e164_key": "1-BS-0"
      },
      {
        "e164_cc": "973",
        "iso2_cc": "BH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Bahrain",
        "example": "36001234",
        "display_name": "Bahrain (BH) [+973]",
        "full_example_with_plus_sign": "+97336001234",
        "display_name_no_e164_cc": "Bahrain (BH)",
        "e164_key": "973-BH-0"
      },
      {
        "e164_cc": "880",
        "iso2_cc": "BD",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Bangladesh",
        "example": "1812345678",
        "display_name": "Bangladesh (BD) [+880]",
        "full_example_with_plus_sign": "+8801812345678",
        "display_name_no_e164_cc": "Bangladesh (BD)",
        "e164_key": "880-BD-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "BB",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Barbados",
        "example": "2462501234",
        "display_name": "Barbados (BB) [+1]",
        "full_example_with_plus_sign": "+12462501234",
        "display_name_no_e164_cc": "Barbados (BB)",
        "e164_key": "1-BB-0"
      },
      {
        "e164_cc": "375",
        "iso2_cc": "BY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Belarus",
        "example": "294911911",
        "display_name": "Belarus (BY) [+375]",
        "full_example_with_plus_sign": "+375294911911",
        "display_name_no_e164_cc": "Belarus (BY)",
        "e164_key": "375-BY-0"
      },
      {
        "e164_cc": "32",
        "iso2_cc": "BE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Belgium",
        "example": "470123456",
        "display_name": "Belgium (BE) [+32]",
        "full_example_with_plus_sign": "+32470123456",
        "display_name_no_e164_cc": "Belgium (BE)",
        "e164_key": "32-BE-0"
      },
      {
        "e164_cc": "501",
        "iso2_cc": "BZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Belize",
        "example": "6221234",
        "display_name": "Belize (BZ) [+501]",
        "full_example_with_plus_sign": "+5016221234",
        "display_name_no_e164_cc": "Belize (BZ)",
        "e164_key": "501-BZ-0"
      },
      {
        "e164_cc": "229",
        "iso2_cc": "BJ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Benin",
        "example": "90011234",
        "display_name": "Benin (BJ) [+229]",
        "full_example_with_plus_sign": "+22990011234",
        "display_name_no_e164_cc": "Benin (BJ)",
        "e164_key": "229-BJ-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "BM",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Bermuda",
        "example": "4413701234",
        "display_name": "Bermuda (BM) [+1]",
        "full_example_with_plus_sign": "+14413701234",
        "display_name_no_e164_cc": "Bermuda (BM)",
        "e164_key": "1-BM-0"
      },
      {
        "e164_cc": "975",
        "iso2_cc": "BT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Bhutan",
        "example": "17123456",
        "display_name": "Bhutan (BT) [+975]",
        "full_example_with_plus_sign": "+97517123456",
        "display_name_no_e164_cc": "Bhutan (BT)",
        "e164_key": "975-BT-0"
      },
      {
        "e164_cc": "591",
        "iso2_cc": "BO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Bolivia",
        "example": "71234567",
        "display_name": "Bolivia (BO) [+591]",
        "full_example_with_plus_sign": "+59171234567",
        "display_name_no_e164_cc": "Bolivia (BO)",
        "e164_key": "591-BO-0"
      },
      {
        "e164_cc": "387",
        "iso2_cc": "BA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Bosnia and Herzegovina",
        "example": "61123456",
        "display_name": "Bosnia and Herzegovina (BA) [+387]",
        "full_example_with_plus_sign": "+38761123456",
        "display_name_no_e164_cc": "Bosnia and Herzegovina (BA)",
        "e164_key": "387-BA-0"
      },
      {
        "e164_cc": "267",
        "iso2_cc": "BW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Botswana",
        "example": "71123456",
        "display_name": "Botswana (BW) [+267]",
        "full_example_with_plus_sign": "+26771123456",
        "display_name_no_e164_cc": "Botswana (BW)",
        "e164_key": "267-BW-0"
      },
      {
        "e164_cc": "55",
        "iso2_cc": "BR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Brazil",
        "example": "1161234567",
        "display_name": "Brazil (BR) [+55]",
        "full_example_with_plus_sign": "+551161234567",
        "display_name_no_e164_cc": "Brazil (BR)",
        "e164_key": "55-BR-0"
      },
      {
        "e164_cc": "246",
        "iso2_cc": "IO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "British Indian Ocean Territory",
        "example": "3801234",
        "display_name": "British Indian Ocean Territory (IO) [+246]",
        "full_example_with_plus_sign": "+2463801234",
        "display_name_no_e164_cc": "British Indian Ocean Territory (IO)",
        "e164_key": "246-IO-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "VG",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "British Virgin Islands",
        "example": "2843001234",
        "display_name": "British Virgin Islands (VG) [+1]",
        "full_example_with_plus_sign": "+12843001234",
        "display_name_no_e164_cc": "British Virgin Islands (VG)",
        "e164_key": "1-VG-0"
      },
      {
        "e164_cc": "673",
        "iso2_cc": "BN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Brunei",
        "example": "7123456",
        "display_name": "Brunei (BN) [+673]",
        "full_example_with_plus_sign": "+6737123456",
        "display_name_no_e164_cc": "Brunei (BN)",
        "e164_key": "673-BN-0"
      },
      {
        "e164_cc": "359",
        "iso2_cc": "BG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Bulgaria",
        "example": "48123456",
        "display_name": "Bulgaria (BG) [+359]",
        "full_example_with_plus_sign": "+35948123456",
        "display_name_no_e164_cc": "Bulgaria (BG)",
        "e164_key": "359-BG-0"
      },
      {
        "e164_cc": "226",
        "iso2_cc": "BF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Burkina Faso",
        "example": "70123456",
        "display_name": "Burkina Faso (BF) [+226]",
        "full_example_with_plus_sign": "+22670123456",
        "display_name_no_e164_cc": "Burkina Faso (BF)",
        "e164_key": "226-BF-0"
      },
      {
        "e164_cc": "257",
        "iso2_cc": "BI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Burundi",
        "example": "79561234",
        "display_name": "Burundi (BI) [+257]",
        "full_example_with_plus_sign": "+25779561234",
        "display_name_no_e164_cc": "Burundi (BI)",
        "e164_key": "257-BI-0"
      },
      {
        "e164_cc": "855",
        "iso2_cc": "KH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Cambodia",
        "example": "91234567",
        "display_name": "Cambodia (KH) [+855]",
        "full_example_with_plus_sign": "+85591234567",
        "display_name_no_e164_cc": "Cambodia (KH)",
        "e164_key": "855-KH-0"
      },
      {
        "e164_cc": "237",
        "iso2_cc": "CM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Cameroon",
        "example": "71234567",
        "display_name": "Cameroon (CM) [+237]",
        "full_example_with_plus_sign": "+23771234567",
        "display_name_no_e164_cc": "Cameroon (CM)",
        "e164_key": "237-CM-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "CA",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Canada",
        "example": "2042345678",
        "display_name": "Canada (CA) [+1]",
        "full_example_with_plus_sign": "+12042345678",
        "display_name_no_e164_cc": "Canada (CA)",
        "e164_key": "1-CA-0"
      },
      {
        "e164_cc": "238",
        "iso2_cc": "CV",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Cape Verde",
        "example": "9911234",
        "display_name": "Cape Verde (CV) [+238]",
        "full_example_with_plus_sign": "+2389911234",
        "display_name_no_e164_cc": "Cape Verde (CV)",
        "e164_key": "238-CV-0"
      },
      {
        "e164_cc": "599",
        "iso2_cc": "BQ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Caribbean Netherlands",
        "example": "3181234",
        "display_name": "Caribbean Netherlands (BQ) [+599]",
        "full_example_with_plus_sign": "+5993181234",
        "display_name_no_e164_cc": "Caribbean Netherlands (BQ)",
        "e164_key": "599-BQ-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "KY",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Cayman Islands",
        "example": "3453231234",
        "display_name": "Cayman Islands (KY) [+1]",
        "full_example_with_plus_sign": "+13453231234",
        "display_name_no_e164_cc": "Cayman Islands (KY)",
        "e164_key": "1-KY-0"
      },
      {
        "e164_cc": "236",
        "iso2_cc": "CF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Central African Republic",
        "example": "70012345",
        "display_name": "Central African Republic (CF) [+236]",
        "full_example_with_plus_sign": "+23670012345",
        "display_name_no_e164_cc": "Central African Republic (CF)",
        "e164_key": "236-CF-0"
      },
      {
        "e164_cc": "235",
        "iso2_cc": "TD",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Chad",
        "example": "63012345",
        "display_name": "Chad (TD) [+235]",
        "full_example_with_plus_sign": "+23563012345",
        "display_name_no_e164_cc": "Chad (TD)",
        "e164_key": "235-TD-0"
      },
      {
        "e164_cc": "56",
        "iso2_cc": "CL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Chile",
        "example": "961234567",
        "display_name": "Chile (CL) [+56]",
        "full_example_with_plus_sign": "+56961234567",
        "display_name_no_e164_cc": "Chile (CL)",
        "e164_key": "56-CL-0"
      },
      {
        "e164_cc": "86",
        "iso2_cc": "CN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "China",
        "example": "13123456789",
        "display_name": "China (CN) [+86]",
        "full_example_with_plus_sign": "+8613123456789",
        "display_name_no_e164_cc": "China (CN)",
        "e164_key": "86-CN-0"
      },
      {
        "e164_cc": "61",
        "iso2_cc": "CX",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "Christmas Island",
        "example": "412345678",
        "display_name": "Christmas Island (CX) [+61]",
        "full_example_with_plus_sign": "+61412345678",
        "display_name_no_e164_cc": "Christmas Island (CX)",
        "e164_key": "61-CX-0"
      },
      {
        "e164_cc": "61",
        "iso2_cc": "CC",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "Cocos [Keeling] Islands",
        "example": "412345678",
        "display_name": "Cocos [Keeling] Islands (CC) [+61]",
        "full_example_with_plus_sign": "+61412345678",
        "display_name_no_e164_cc": "Cocos [Keeling] Islands (CC)",
        "e164_key": "61-CC-0"
      },
      {
        "e164_cc": "57",
        "iso2_cc": "CO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Colombia",
        "example": "3211234567",
        "display_name": "Colombia (CO) [+57]",
        "full_example_with_plus_sign": "+573211234567",
        "display_name_no_e164_cc": "Colombia (CO)",
        "e164_key": "57-CO-0"
      },
      {
        "e164_cc": "269",
        "iso2_cc": "KM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Comoros",
        "example": "3212345",
        "display_name": "Comoros (KM) [+269]",
        "full_example_with_plus_sign": "+2693212345",
        "display_name_no_e164_cc": "Comoros (KM)",
        "e164_key": "269-KM-0"
      },
      {
        "e164_cc": "243",
        "iso2_cc": "CD",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Democratic Republic Congo",
        "example": "991234567",
        "display_name": "Democratic Republic Congo (CD) [+243]",
        "full_example_with_plus_sign": "+243991234567",
        "display_name_no_e164_cc": "Democratic Republic Congo (CD)",
        "e164_key": "243-CD-0"
      },
      {
        "e164_cc": "242",
        "iso2_cc": "CG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Republic of Congo",
        "example": "061234567",
        "display_name": "Republic of Congo (CG) [+242]",
        "full_example_with_plus_sign": "+242061234567",
        "display_name_no_e164_cc": "Republic of Congo (CG)",
        "e164_key": "242-CG-0"
      },
      {
        "e164_cc": "682",
        "iso2_cc": "CK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Cook Islands",
        "example": "71234",
        "display_name": "Cook Islands (CK) [+682]",
        "full_example_with_plus_sign": "+68271234",
        "display_name_no_e164_cc": "Cook Islands (CK)",
        "e164_key": "682-CK-0"
      },
      {
        "e164_cc": "506",
        "iso2_cc": "CR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Costa Rica",
        "example": "83123456",
        "display_name": "Costa Rica (CR) [+506]",
        "full_example_with_plus_sign": "+50683123456",
        "display_name_no_e164_cc": "Costa Rica (CR)",
        "e164_key": "506-CR-0"
      },
      {
        "e164_cc": "225",
        "iso2_cc": "CI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Côte d'Ivoire",
        "example": "01234567",
        "display_name": "Côte d'Ivoire (CI) [+225]",
        "full_example_with_plus_sign": "+22501234567",
        "display_name_no_e164_cc": "Côte d'Ivoire (CI)",
        "e164_key": "225-CI-0"
      },
      {
        "e164_cc": "385",
        "iso2_cc": "HR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Croatia",
        "example": "912345678",
        "display_name": "Croatia (HR) [+385]",
        "full_example_with_plus_sign": "+385912345678",
        "display_name_no_e164_cc": "Croatia (HR)",
        "e164_key": "385-HR-0"
      },
      {
        "e164_cc": "53",
        "iso2_cc": "CU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Cuba",
        "example": "51234567",
        "display_name": "Cuba (CU) [+53]",
        "full_example_with_plus_sign": "+5351234567",
        "display_name_no_e164_cc": "Cuba (CU)",
        "e164_key": "53-CU-0"
      },
      {
        "e164_cc": "599",
        "iso2_cc": "CW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Curaçao",
        "example": "95181234",
        "display_name": "Curaçao (CW) [+599]",
        "full_example_with_plus_sign": "+59995181234",
        "display_name_no_e164_cc": "Curaçao (CW)",
        "e164_key": "599-CW-0"
      },
      {
        "e164_cc": "357",
        "iso2_cc": "CY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Cyprus",
        "example": "96123456",
        "display_name": "Cyprus (CY) [+357]",
        "full_example_with_plus_sign": "+35796123456",
        "display_name_no_e164_cc": "Cyprus (CY)",
        "e164_key": "357-CY-0"
      },
      {
        "e164_cc": "420",
        "iso2_cc": "CZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Czech Republic",
        "example": "601123456",
        "display_name": "Czech Republic (CZ) [+420]",
        "full_example_with_plus_sign": "+420601123456",
        "display_name_no_e164_cc": "Czech Republic (CZ)",
        "e164_key": "420-CZ-0"
      },
      {
        "e164_cc": "45",
        "iso2_cc": "DK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Denmark",
        "example": "20123456",
        "display_name": "Denmark (DK) [+45]",
        "full_example_with_plus_sign": "+4520123456",
        "display_name_no_e164_cc": "Denmark (DK)",
        "e164_key": "45-DK-0"
      },
      {
        "e164_cc": "253",
        "iso2_cc": "DJ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Djibouti",
        "example": "77831001",
        "display_name": "Djibouti (DJ) [+253]",
        "full_example_with_plus_sign": "+25377831001",
        "display_name_no_e164_cc": "Djibouti (DJ)",
        "e164_key": "253-DJ-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "DM",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Dominica",
        "example": "7672251234",
        "display_name": "Dominica (DM) [+1]",
        "full_example_with_plus_sign": "+17672251234",
        "display_name_no_e164_cc": "Dominica (DM)",
        "e164_key": "1-DM-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "DO",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Dominican Republic",
        "example": "8092345678",
        "display_name": "Dominican Republic (DO) [+1]",
        "full_example_with_plus_sign": "+18092345678",
        "display_name_no_e164_cc": "Dominican Republic (DO)",
        "e164_key": "1-DO-0"
      },
      {
        "e164_cc": "670",
        "iso2_cc": "TL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "East Timor",
        "example": "77212345",
        "display_name": "East Timor (TL) [+670]",
        "full_example_with_plus_sign": "+67077212345",
        "display_name_no_e164_cc": "East Timor (TL)",
        "e164_key": "670-TL-0"
      },
      {
        "e164_cc": "593",
        "iso2_cc": "EC",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Ecuador",
        "example": "99123456",
        "display_name": "Ecuador (EC) [+593]",
        "full_example_with_plus_sign": "+59399123456",
        "display_name_no_e164_cc": "Ecuador (EC)",
        "e164_key": "593-EC-0"
      },
      {
        "e164_cc": "20",
        "iso2_cc": "EG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Egypt",
        "example": "1001234567",
        "display_name": "Egypt (EG) [+20]",
        "full_example_with_plus_sign": "+201001234567",
        "display_name_no_e164_cc": "Egypt (EG)",
        "e164_key": "20-EG-0"
      },
      {
        "e164_cc": "503",
        "iso2_cc": "SV",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "El Salvador",
        "example": "70123456",
        "display_name": "El Salvador (SV) [+503]",
        "full_example_with_plus_sign": "+50370123456",
        "display_name_no_e164_cc": "El Salvador (SV)",
        "e164_key": "503-SV-0"
      },
      {
        "e164_cc": "240",
        "iso2_cc": "GQ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Equatorial Guinea",
        "example": "222123456",
        "display_name": "Equatorial Guinea (GQ) [+240]",
        "full_example_with_plus_sign": "+240222123456",
        "display_name_no_e164_cc": "Equatorial Guinea (GQ)",
        "e164_key": "240-GQ-0"
      },
      {
        "e164_cc": "291",
        "iso2_cc": "ER",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Eritrea",
        "example": "7123456",
        "display_name": "Eritrea (ER) [+291]",
        "full_example_with_plus_sign": "+2917123456",
        "display_name_no_e164_cc": "Eritrea (ER)",
        "e164_key": "291-ER-0"
      },
      {
        "e164_cc": "372",
        "iso2_cc": "EE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Estonia",
        "example": "51234567",
        "display_name": "Estonia (EE) [+372]",
        "full_example_with_plus_sign": "+37251234567",
        "display_name_no_e164_cc": "Estonia (EE)",
        "e164_key": "372-EE-0"
      },
      {
        "e164_cc": "268",
        "iso2_cc": "SZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Eswatini",
        "example": "76123456",
        "display_name": "Eswatini (SZ) [+268]",
        "full_example_with_plus_sign": "+26876123456",
        "display_name_no_e164_cc": "Eswatini (SZ)",
        "e164_key": "268-SZ-0"
      },
      {
        "e164_cc": "251",
        "iso2_cc": "ET",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Ethiopia",
        "example": "911234567",
        "display_name": "Ethiopia (ET) [+251]",
        "full_example_with_plus_sign": "+251911234567",
        "display_name_no_e164_cc": "Ethiopia (ET)",
        "e164_key": "251-ET-0"
      },
      {
        "e164_cc": "500",
        "iso2_cc": "FK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Falkland Islands [Islas Malvinas]",
        "example": "51234",
        "display_name": "Falkland Islands [Islas Malvinas] (FK) [+500]",
        "full_example_with_plus_sign": "+50051234",
        "display_name_no_e164_cc": "Falkland Islands [Islas Malvinas] (FK)",
        "e164_key": "500-FK-0"
      },
      {
        "e164_cc": "298",
        "iso2_cc": "FO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Faroe Islands",
        "example": "211234",
        "display_name": "Faroe Islands (FO) [+298]",
        "full_example_with_plus_sign": "+298211234",
        "display_name_no_e164_cc": "Faroe Islands (FO)",
        "e164_key": "298-FO-0"
      },
      {
        "e164_cc": "679",
        "iso2_cc": "FJ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Fiji",
        "example": "7012345",
        "display_name": "Fiji (FJ) [+679]",
        "full_example_with_plus_sign": "+6797012345",
        "display_name_no_e164_cc": "Fiji (FJ)",
        "e164_key": "679-FJ-0"
      },
      {
        "e164_cc": "358",
        "iso2_cc": "FI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Finland",
        "example": "412345678",
        "display_name": "Finland (FI) [+358]",
        "full_example_with_plus_sign": "+358412345678",
        "display_name_no_e164_cc": "Finland (FI)",
        "e164_key": "358-FI-0"
      },
      {
        "e164_cc": "33",
        "iso2_cc": "FR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "France",
        "example": "612345678",
        "display_name": "France (FR) [+33]",
        "full_example_with_plus_sign": "+33612345678",
        "display_name_no_e164_cc": "France (FR)",
        "e164_key": "33-FR-0"
      },
      {
        "e164_cc": "594",
        "iso2_cc": "GF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "French Guiana",
        "example": "694201234",
        "display_name": "French Guiana (GF) [+594]",
        "full_example_with_plus_sign": "+594694201234",
        "display_name_no_e164_cc": "French Guiana (GF)",
        "e164_key": "594-GF-0"
      },
      {
        "e164_cc": "689",
        "iso2_cc": "PF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "French Polynesia",
        "example": "212345",
        "display_name": "French Polynesia (PF) [+689]",
        "full_example_with_plus_sign": "+689212345",
        "display_name_no_e164_cc": "French Polynesia (PF)",
        "e164_key": "689-PF-0"
      },
      {
        "e164_cc": "241",
        "iso2_cc": "GA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Gabon",
        "example": "06031234",
        "display_name": "Gabon (GA) [+241]",
        "full_example_with_plus_sign": "+24106031234",
        "display_name_no_e164_cc": "Gabon (GA)",
        "e164_key": "241-GA-0"
      },
      {
        "e164_cc": "220",
        "iso2_cc": "GM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Gambia",
        "example": "3012345",
        "display_name": "Gambia (GM) [+220]",
        "full_example_with_plus_sign": "+2203012345",
        "display_name_no_e164_cc": "Gambia (GM)",
        "e164_key": "220-GM-0"
      },
      {
        "e164_cc": "995",
        "iso2_cc": "GE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Georgia",
        "example": "555123456",
        "display_name": "Georgia (GE) [+995]",
        "full_example_with_plus_sign": "+995555123456",
        "display_name_no_e164_cc": "Georgia (GE)",
        "e164_key": "995-GE-0"
      },
      {
        "e164_cc": "49",
        "iso2_cc": "DE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Germany",
        "example": "15123456789",
        "display_name": "Germany (DE) [+49]",
        "full_example_with_plus_sign": "+4915123456789",
        "display_name_no_e164_cc": "Germany (DE)",
        "e164_key": "49-DE-0"
      },
      {
        "e164_cc": "233",
        "iso2_cc": "GH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Ghana",
        "example": "231234567",
        "display_name": "Ghana (GH) [+233]",
        "full_example_with_plus_sign": "+233231234567",
        "display_name_no_e164_cc": "Ghana (GH)",
        "e164_key": "233-GH-0"
      },
      {
        "e164_cc": "350",
        "iso2_cc": "GI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Gibraltar",
        "example": "57123456",
        "display_name": "Gibraltar (GI) [+350]",
        "full_example_with_plus_sign": "+35057123456",
        "display_name_no_e164_cc": "Gibraltar (GI)",
        "e164_key": "350-GI-0"
      },
      {
        "e164_cc": "30",
        "iso2_cc": "GR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Greece",
        "example": "6912345678",
        "display_name": "Greece (GR) [+30]",
        "full_example_with_plus_sign": "+306912345678",
        "display_name_no_e164_cc": "Greece (GR)",
        "e164_key": "30-GR-0"
      },
      {
        "e164_cc": "299",
        "iso2_cc": "GL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Greenland",
        "example": "221234",
        "display_name": "Greenland (GL) [+299]",
        "full_example_with_plus_sign": "+299221234",
        "display_name_no_e164_cc": "Greenland (GL)",
        "e164_key": "299-GL-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "GD",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Grenada",
        "example": "4734031234",
        "display_name": "Grenada (GD) [+1]",
        "full_example_with_plus_sign": "+14734031234",
        "display_name_no_e164_cc": "Grenada (GD)",
        "e164_key": "1-GD-0"
      },
      {
        "e164_cc": "590",
        "iso2_cc": "GP",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Guadeloupe",
        "example": "690301234",
        "display_name": "Guadeloupe (GP) [+590]",
        "full_example_with_plus_sign": "+590690301234",
        "display_name_no_e164_cc": "Guadeloupe (GP)",
        "e164_key": "590-GP-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "GU",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Guam",
        "example": "6713001234",
        "display_name": "Guam (GU) [+1]",
        "full_example_with_plus_sign": "+16713001234",
        "display_name_no_e164_cc": "Guam (GU)",
        "e164_key": "1-GU-0"
      },
      {
        "e164_cc": "502",
        "iso2_cc": "GT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Guatemala",
        "example": "51234567",
        "display_name": "Guatemala (GT) [+502]",
        "full_example_with_plus_sign": "+50251234567",
        "display_name_no_e164_cc": "Guatemala (GT)",
        "e164_key": "502-GT-0"
      },
      {
        "e164_cc": "44",
        "iso2_cc": "GG",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Guernsey",
        "example": "7781123456",
        "display_name": "Guernsey (GG) [+44]",
        "full_example_with_plus_sign": "+447781123456",
        "display_name_no_e164_cc": "Guernsey (GG)",
        "e164_key": "44-GG-0"
      },
      {
        "e164_cc": "224",
        "iso2_cc": "GN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Guinea Conakry",
        "example": "60201234",
        "display_name": "Guinea Conakry (GN) [+224]",
        "full_example_with_plus_sign": "+22460201234",
        "display_name_no_e164_cc": "Guinea Conakry (GN)",
        "e164_key": "224-GN-0"
      },
      {
        "e164_cc": "245",
        "iso2_cc": "GW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Guinea-Bissau",
        "example": "5012345",
        "display_name": "Guinea-Bissau (GW) [+245]",
        "full_example_with_plus_sign": "+2455012345",
        "display_name_no_e164_cc": "Guinea-Bissau (GW)",
        "e164_key": "245-GW-0"
      },
      {
        "e164_cc": "592",
        "iso2_cc": "GY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Guyana",
        "example": "6091234",
        "display_name": "Guyana (GY) [+592]",
        "full_example_with_plus_sign": "+5926091234",
        "display_name_no_e164_cc": "Guyana (GY)",
        "e164_key": "592-GY-0"
      },
      {
        "e164_cc": "509",
        "iso2_cc": "HT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Haiti",
        "example": "34101234",
        "display_name": "Haiti (HT) [+509]",
        "full_example_with_plus_sign": "+50934101234",
        "display_name_no_e164_cc": "Haiti (HT)",
        "e164_key": "509-HT-0"
      },
      {
        "e164_cc": "672",
        "iso2_cc": "HM",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "Heard Island and McDonald Islands",
        "example": "",
        "display_name": "Heard Island and McDonald Islands (HM) [+672]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Heard Island and McDonald Islands (HM)",
        "e164_key": "672-HM-0"
      },
      {
        "e164_cc": "504",
        "iso2_cc": "HN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Honduras",
        "example": "91234567",
        "display_name": "Honduras (HN) [+504]",
        "full_example_with_plus_sign": "+50491234567",
        "display_name_no_e164_cc": "Honduras (HN)",
        "e164_key": "504-HN-0"
      },
      {
        "e164_cc": "852",
        "iso2_cc": "HK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Hong Kong",
        "example": "51234567",
        "display_name": "Hong Kong (HK) [+852]",
        "full_example_with_plus_sign": "+85251234567",
        "display_name_no_e164_cc": "Hong Kong (HK)",
        "e164_key": "852-HK-0"
      },
      {
        "e164_cc": "36",
        "iso2_cc": "HU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Hungary",
        "example": "201234567",
        "display_name": "Hungary (HU) [+36]",
        "full_example_with_plus_sign": "+36201234567",
        "display_name_no_e164_cc": "Hungary (HU)",
        "e164_key": "36-HU-0"
      },
      {
        "e164_cc": "354",
        "iso2_cc": "IS",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Iceland",
        "example": "6101234",
        "display_name": "Iceland (IS) [+354]",
        "full_example_with_plus_sign": "+3546101234",
        "display_name_no_e164_cc": "Iceland (IS)",
        "e164_key": "354-IS-0"
      },
      {
        "e164_cc": "91",
        "iso2_cc": "IN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "India",
        "example": "9123456789",
        "display_name": "India (IN) [+91]",
        "full_example_with_plus_sign": "+919123456789",
        "display_name_no_e164_cc": "India (IN)",
        "e164_key": "91-IN-0"
      },
      {
        "e164_cc": "62",
        "iso2_cc": "ID",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Indonesia",
        "example": "812345678",
        "display_name": "Indonesia (ID) [+62]",
        "full_example_with_plus_sign": "+62812345678",
        "display_name_no_e164_cc": "Indonesia (ID)",
        "e164_key": "62-ID-0"
      },
      {
        "e164_cc": "98",
        "iso2_cc": "IR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Iran",
        "example": "9123456789",
        "display_name": "Iran (IR) [+98]",
        "full_example_with_plus_sign": "+989123456789",
        "display_name_no_e164_cc": "Iran (IR)",
        "e164_key": "98-IR-0"
      },
      {
        "e164_cc": "964",
        "iso2_cc": "IQ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Iraq",
        "example": "7912345678",
        "display_name": "Iraq (IQ) [+964]",
        "full_example_with_plus_sign": "+9647912345678",
        "display_name_no_e164_cc": "Iraq (IQ)",
        "e164_key": "964-IQ-0"
      },
      {
        "e164_cc": "353",
        "iso2_cc": "IE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Ireland",
        "example": "850123456",
        "display_name": "Ireland (IE) [+353]",
        "full_example_with_plus_sign": "+353850123456",
        "display_name_no_e164_cc": "Ireland (IE)",
        "e164_key": "353-IE-0"
      },
      {
        "e164_cc": "44",
        "iso2_cc": "IM",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Isle of Man",
        "example": "7924123456",
        "display_name": "Isle of Man (IM) [+44]",
        "full_example_with_plus_sign": "+447924123456",
        "display_name_no_e164_cc": "Isle of Man (IM)",
        "e164_key": "44-IM-0"
      },
      {
        "e164_cc": "972",
        "iso2_cc": "IL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Israel",
        "example": "501234567",
        "display_name": "Israel (IL) [+972]",
        "full_example_with_plus_sign": "+972501234567",
        "display_name_no_e164_cc": "Israel (IL)",
        "e164_key": "972-IL-0"
      },
      {
        "e164_cc": "39",
        "iso2_cc": "IT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Italy",
        "example": "3123456789",
        "display_name": "Italy (IT) [+39]",
        "full_example_with_plus_sign": "+393123456789",
        "display_name_no_e164_cc": "Italy (IT)",
        "e164_key": "39-IT-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "JM",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Jamaica",
        "example": "8762101234",
        "display_name": "Jamaica (JM) [+1]",
        "full_example_with_plus_sign": "+18762101234",
        "display_name_no_e164_cc": "Jamaica (JM)",
        "e164_key": "1-JM-0"
      },
      {
        "e164_cc": "81",
        "iso2_cc": "JP",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Japan",
        "example": "7012345678",
        "display_name": "Japan (JP) [+81]",
        "full_example_with_plus_sign": "+817012345678",
        "display_name_no_e164_cc": "Japan (JP)",
        "e164_key": "81-JP-0"
      },
      {
        "e164_cc": "44",
        "iso2_cc": "JE",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Jersey",
        "example": "7797123456",
        "display_name": "Jersey (JE) [+44]",
        "full_example_with_plus_sign": "+447797123456",
        "display_name_no_e164_cc": "Jersey (JE)",
        "e164_key": "44-JE-0"
      },
      {
        "e164_cc": "962",
        "iso2_cc": "JO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Jordan",
        "example": "790123456",
        "display_name": "Jordan (JO) [+962]",
        "full_example_with_plus_sign": "+962790123456",
        "display_name_no_e164_cc": "Jordan (JO)",
        "e164_key": "962-JO-0"
      },
      {
        "e164_cc": "7",
        "iso2_cc": "KZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Kazakhstan",
        "example": "7710009998",
        "display_name": "Kazakhstan (KZ) [+7]",
        "full_example_with_plus_sign": "+77710009998",
        "display_name_no_e164_cc": "Kazakhstan (KZ)",
        "e164_key": "7-KZ-0"
      },
      {
        "e164_cc": "254",
        "iso2_cc": "KE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Kenya",
        "example": "712123456",
        "display_name": "Kenya (KE) [+254]",
        "full_example_with_plus_sign": "+254712123456",
        "display_name_no_e164_cc": "Kenya (KE)",
        "e164_key": "254-KE-0"
      },
      {
        "e164_cc": "686",
        "iso2_cc": "KI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Kiribati",
        "example": "61234",
        "display_name": "Kiribati (KI) [+686]",
        "full_example_with_plus_sign": "+68661234",
        "display_name_no_e164_cc": "Kiribati (KI)",
        "e164_key": "686-KI-0"
      },
      {
        "e164_cc": "383",
        "iso2_cc": "XK",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Kosovo",
        "example": "",
        "display_name": "Kosovo (XK) [+383]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Kosovo (XK)",
        "e164_key": "383-XK-0"
      },
      {
        "e164_cc": "381",
        "iso2_cc": "XK",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Kosovo",
        "example": "",
        "display_name": "Kosovo (XK) [+381]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Kosovo (XK)",
        "e164_key": "381-XK-0"
      },
      {
        "e164_cc": "386",
        "iso2_cc": "XK",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Kosovo",
        "example": "",
        "display_name": "Kosovo (XK) [+386]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Kosovo (XK)",
        "e164_key": "386-XK-0"
      },
      {
        "e164_cc": "965",
        "iso2_cc": "KW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Kuwait",
        "example": "50012345",
        "display_name": "Kuwait (KW) [+965]",
        "full_example_with_plus_sign": "+96550012345",
        "display_name_no_e164_cc": "Kuwait (KW)",
        "e164_key": "965-KW-0"
      },
      {
        "e164_cc": "996",
        "iso2_cc": "KG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Kyrgyzstan",
        "example": "700123456",
        "display_name": "Kyrgyzstan (KG) [+996]",
        "full_example_with_plus_sign": "+996700123456",
        "display_name_no_e164_cc": "Kyrgyzstan (KG)",
        "e164_key": "996-KG-0"
      },
      {
        "e164_cc": "856",
        "iso2_cc": "LA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Laos",
        "example": "2023123456",
        "display_name": "Laos (LA) [+856]",
        "full_example_with_plus_sign": "+8562023123456",
        "display_name_no_e164_cc": "Laos (LA)",
        "e164_key": "856-LA-0"
      },
      {
        "e164_cc": "371",
        "iso2_cc": "LV",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Latvia",
        "example": "21234567",
        "display_name": "Latvia (LV) [+371]",
        "full_example_with_plus_sign": "+37121234567",
        "display_name_no_e164_cc": "Latvia (LV)",
        "e164_key": "371-LV-0"
      },
      {
        "e164_cc": "961",
        "iso2_cc": "LB",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Lebanon",
        "example": "71123456",
        "display_name": "Lebanon (LB) [+961]",
        "full_example_with_plus_sign": "+96171123456",
        "display_name_no_e164_cc": "Lebanon (LB)",
        "e164_key": "961-LB-0"
      },
      {
        "e164_cc": "266",
        "iso2_cc": "LS",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Lesotho",
        "example": "50123456",
        "display_name": "Lesotho (LS) [+266]",
        "full_example_with_plus_sign": "+26650123456",
        "display_name_no_e164_cc": "Lesotho (LS)",
        "e164_key": "266-LS-0"
      },
      {
        "e164_cc": "231",
        "iso2_cc": "LR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Liberia",
        "example": "4612345",
        "display_name": "Liberia (LR) [+231]",
        "full_example_with_plus_sign": "+2314612345",
        "display_name_no_e164_cc": "Liberia (LR)",
        "e164_key": "231-LR-0"
      },
      {
        "e164_cc": "218",
        "iso2_cc": "LY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Libya",
        "example": "912345678",
        "display_name": "Libya (LY) [+218]",
        "full_example_with_plus_sign": "+218912345678",
        "display_name_no_e164_cc": "Libya (LY)",
        "e164_key": "218-LY-0"
      },
      {
        "e164_cc": "423",
        "iso2_cc": "LI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Liechtenstein",
        "example": "661234567",
        "display_name": "Liechtenstein (LI) [+423]",
        "full_example_with_plus_sign": "+423661234567",
        "display_name_no_e164_cc": "Liechtenstein (LI)",
        "e164_key": "423-LI-0"
      },
      {
        "e164_cc": "370",
        "iso2_cc": "LT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Lithuania",
        "example": "61234567",
        "display_name": "Lithuania (LT) [+370]",
        "full_example_with_plus_sign": "+37061234567",
        "display_name_no_e164_cc": "Lithuania (LT)",
        "e164_key": "370-LT-0"
      },
      {
        "e164_cc": "352",
        "iso2_cc": "LU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Luxembourg",
        "example": "628123456",
        "display_name": "Luxembourg (LU) [+352]",
        "full_example_with_plus_sign": "+352628123456",
        "display_name_no_e164_cc": "Luxembourg (LU)",
        "e164_key": "352-LU-0"
      },
      {
        "e164_cc": "853",
        "iso2_cc": "MO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Macau",
        "example": "66123456",
        "display_name": "Macau (MO) [+853]",
        "full_example_with_plus_sign": "+85366123456",
        "display_name_no_e164_cc": "Macau (MO)",
        "e164_key": "853-MO-0"
      },
      {
        "e164_cc": "389",
        "iso2_cc": "MK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Macedonia",
        "example": "72345678",
        "display_name": "Macedonia (MK) [+389]",
        "full_example_with_plus_sign": "+38972345678",
        "display_name_no_e164_cc": "Macedonia (MK)",
        "e164_key": "389-MK-0"
      },
      {
        "e164_cc": "261",
        "iso2_cc": "MG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Madagascar",
        "example": "301234567",
        "display_name": "Madagascar (MG) [+261]",
        "full_example_with_plus_sign": "+261301234567",
        "display_name_no_e164_cc": "Madagascar (MG)",
        "e164_key": "261-MG-0"
      },
      {
        "e164_cc": "265",
        "iso2_cc": "MW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Malawi",
        "example": "991234567",
        "display_name": "Malawi (MW) [+265]",
        "full_example_with_plus_sign": "+265991234567",
        "display_name_no_e164_cc": "Malawi (MW)",
        "e164_key": "265-MW-0"
      },
      {
        "e164_cc": "60",
        "iso2_cc": "MY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Malaysia",
        "example": "123456789",
        "display_name": "Malaysia (MY) [+60]",
        "full_example_with_plus_sign": "+60123456789",
        "display_name_no_e164_cc": "Malaysia (MY)",
        "e164_key": "60-MY-0"
      },
      {
        "e164_cc": "960",
        "iso2_cc": "MV",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Maldives",
        "example": "7712345",
        "display_name": "Maldives (MV) [+960]",
        "full_example_with_plus_sign": "+9607712345",
        "display_name_no_e164_cc": "Maldives (MV)",
        "e164_key": "960-MV-0"
      },
      {
        "e164_cc": "223",
        "iso2_cc": "ML",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Mali",
        "example": "65012345",
        "display_name": "Mali (ML) [+223]",
        "full_example_with_plus_sign": "+22365012345",
        "display_name_no_e164_cc": "Mali (ML)",
        "e164_key": "223-ML-0"
      },
      {
        "e164_cc": "356",
        "iso2_cc": "MT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Malta",
        "example": "96961234",
        "display_name": "Malta (MT) [+356]",
        "full_example_with_plus_sign": "+35696961234",
        "display_name_no_e164_cc": "Malta (MT)",
        "e164_key": "356-MT-0"
      },
      {
        "e164_cc": "692",
        "iso2_cc": "MH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Marshall Islands",
        "example": "2351234",
        "display_name": "Marshall Islands (MH) [+692]",
        "full_example_with_plus_sign": "+6922351234",
        "display_name_no_e164_cc": "Marshall Islands (MH)",
        "e164_key": "692-MH-0"
      },
      {
        "e164_cc": "596",
        "iso2_cc": "MQ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Martinique",
        "example": "696201234",
        "display_name": "Martinique (MQ) [+596]",
        "full_example_with_plus_sign": "+596696201234",
        "display_name_no_e164_cc": "Martinique (MQ)",
        "e164_key": "596-MQ-0"
      },
      {
        "e164_cc": "222",
        "iso2_cc": "MR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Mauritania",
        "example": "22123456",
        "display_name": "Mauritania (MR) [+222]",
        "full_example_with_plus_sign": "+22222123456",
        "display_name_no_e164_cc": "Mauritania (MR)",
        "e164_key": "222-MR-0"
      },
      {
        "e164_cc": "230",
        "iso2_cc": "MU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Mauritius",
        "example": "2512345",
        "display_name": "Mauritius (MU) [+230]",
        "full_example_with_plus_sign": "+2302512345",
        "display_name_no_e164_cc": "Mauritius (MU)",
        "e164_key": "230-MU-0"
      },
      {
        "e164_cc": "262",
        "iso2_cc": "YT",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Mayotte",
        "example": "639123456",
        "display_name": "Mayotte (YT) [+262]",
        "full_example_with_plus_sign": "+262639123456",
        "display_name_no_e164_cc": "Mayotte (YT)",
        "e164_key": "262-YT-0"
      },
      {
        "e164_cc": "52",
        "iso2_cc": "MX",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Mexico",
        "example": "12221234567",
        "display_name": "Mexico (MX) [+52]",
        "full_example_with_plus_sign": "+5212221234567",
        "display_name_no_e164_cc": "Mexico (MX)",
        "e164_key": "52-MX-0"
      },
      {
        "e164_cc": "691",
        "iso2_cc": "FM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Micronesia",
        "example": "3501234",
        "display_name": "Micronesia (FM) [+691]",
        "full_example_with_plus_sign": "+6913501234",
        "display_name_no_e164_cc": "Micronesia (FM)",
        "e164_key": "691-FM-0"
      },
      {
        "e164_cc": "373",
        "iso2_cc": "MD",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Moldova",
        "example": "65012345",
        "display_name": "Moldova (MD) [+373]",
        "full_example_with_plus_sign": "+37365012345",
        "display_name_no_e164_cc": "Moldova (MD)",
        "e164_key": "373-MD-0"
      },
      {
        "e164_cc": "377",
        "iso2_cc": "MC",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Monaco",
        "example": "612345678",
        "display_name": "Monaco (MC) [+377]",
        "full_example_with_plus_sign": "+377612345678",
        "display_name_no_e164_cc": "Monaco (MC)",
        "e164_key": "377-MC-0"
      },
      {
        "e164_cc": "976",
        "iso2_cc": "MN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Mongolia",
        "example": "88123456",
        "display_name": "Mongolia (MN) [+976]",
        "full_example_with_plus_sign": "+97688123456",
        "display_name_no_e164_cc": "Mongolia (MN)",
        "e164_key": "976-MN-0"
      },
      {
        "e164_cc": "382",
        "iso2_cc": "ME",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Montenegro",
        "example": "67622901",
        "display_name": "Montenegro (ME) [+382]",
        "full_example_with_plus_sign": "+38267622901",
        "display_name_no_e164_cc": "Montenegro (ME)",
        "e164_key": "382-ME-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "MS",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Montserrat",
        "example": "6644923456",
        "display_name": "Montserrat (MS) [+1]",
        "full_example_with_plus_sign": "+16644923456",
        "display_name_no_e164_cc": "Montserrat (MS)",
        "e164_key": "1-MS-0"
      },
      {
        "e164_cc": "212",
        "iso2_cc": "MA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Morocco",
        "example": "650123456",
        "display_name": "Morocco (MA) [+212]",
        "full_example_with_plus_sign": "+212650123456",
        "display_name_no_e164_cc": "Morocco (MA)",
        "e164_key": "212-MA-0"
      },
      {
        "e164_cc": "258",
        "iso2_cc": "MZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Mozambique",
        "example": "821234567",
        "display_name": "Mozambique (MZ) [+258]",
        "full_example_with_plus_sign": "+258821234567",
        "display_name_no_e164_cc": "Mozambique (MZ)",
        "e164_key": "258-MZ-0"
      },
      {
        "e164_cc": "95",
        "iso2_cc": "MM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Myanmar [Burma]",
        "example": "92123456",
        "display_name": "Myanmar [Burma] (MM) [+95]",
        "full_example_with_plus_sign": "+9592123456",
        "display_name_no_e164_cc": "Myanmar [Burma] (MM)",
        "e164_key": "95-MM-0"
      },
      {
        "e164_cc": "264",
        "iso2_cc": "NA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Namibia",
        "example": "811234567",
        "display_name": "Namibia (NA) [+264]",
        "full_example_with_plus_sign": "+264811234567",
        "display_name_no_e164_cc": "Namibia (NA)",
        "e164_key": "264-NA-0"
      },
      {
        "e164_cc": "674",
        "iso2_cc": "NR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Nauru",
        "example": "5551234",
        "display_name": "Nauru (NR) [+674]",
        "full_example_with_plus_sign": "+6745551234",
        "display_name_no_e164_cc": "Nauru (NR)",
        "e164_key": "674-NR-0"
      },
      {
        "e164_cc": "977",
        "iso2_cc": "NP",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Nepal",
        "example": "9841234567",
        "display_name": "Nepal (NP) [+977]",
        "full_example_with_plus_sign": "+9779841234567",
        "display_name_no_e164_cc": "Nepal (NP)",
        "e164_key": "977-NP-0"
      },
      {
        "e164_cc": "31",
        "iso2_cc": "NL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Netherlands",
        "example": "612345678",
        "display_name": "Netherlands (NL) [+31]",
        "full_example_with_plus_sign": "+31612345678",
        "display_name_no_e164_cc": "Netherlands (NL)",
        "e164_key": "31-NL-0"
      },
      {
        "e164_cc": "687",
        "iso2_cc": "NC",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "New Caledonia",
        "example": "751234",
        "display_name": "New Caledonia (NC) [+687]",
        "full_example_with_plus_sign": "+687751234",
        "display_name_no_e164_cc": "New Caledonia (NC)",
        "e164_key": "687-NC-0"
      },
      {
        "e164_cc": "64",
        "iso2_cc": "NZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "New Zealand",
        "example": "211234567",
        "display_name": "New Zealand (NZ) [+64]",
        "full_example_with_plus_sign": "+64211234567",
        "display_name_no_e164_cc": "New Zealand (NZ)",
        "e164_key": "64-NZ-0"
      },
      {
        "e164_cc": "505",
        "iso2_cc": "NI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Nicaragua",
        "example": "81234567",
        "display_name": "Nicaragua (NI) [+505]",
        "full_example_with_plus_sign": "+50581234567",
        "display_name_no_e164_cc": "Nicaragua (NI)",
        "e164_key": "505-NI-0"
      },
      {
        "e164_cc": "227",
        "iso2_cc": "NE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Niger",
        "example": "93123456",
        "display_name": "Niger (NE) [+227]",
        "full_example_with_plus_sign": "+22793123456",
        "display_name_no_e164_cc": "Niger (NE)",
        "e164_key": "227-NE-0"
      },
      {
        "e164_cc": "234",
        "iso2_cc": "NG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Nigeria",
        "example": "8021234567",
        "display_name": "Nigeria (NG) [+234]",
        "full_example_with_plus_sign": "+2348021234567",
        "display_name_no_e164_cc": "Nigeria (NG)",
        "e164_key": "234-NG-0"
      },
      {
        "e164_cc": "683",
        "iso2_cc": "NU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Niue",
        "example": "1234",
        "display_name": "Niue (NU) [+683]",
        "full_example_with_plus_sign": "+6831234",
        "display_name_no_e164_cc": "Niue (NU)",
        "e164_key": "683-NU-0"
      },
      {
        "e164_cc": "672",
        "iso2_cc": "NF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Norfolk Island",
        "example": "381234",
        "display_name": "Norfolk Island (NF) [+672]",
        "full_example_with_plus_sign": "+672381234",
        "display_name_no_e164_cc": "Norfolk Island (NF)",
        "e164_key": "672-NF-0"
      },
      {
        "e164_cc": "850",
        "iso2_cc": "KP",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "North Korea",
        "example": "1921234567",
        "display_name": "North Korea (KP) [+850]",
        "full_example_with_plus_sign": "+8501921234567",
        "display_name_no_e164_cc": "North Korea (KP)",
        "e164_key": "850-KP-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "MP",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Northern Mariana Islands",
        "example": "6702345678",
        "display_name": "Northern Mariana Islands (MP) [+1]",
        "full_example_with_plus_sign": "+16702345678",
        "display_name_no_e164_cc": "Northern Mariana Islands (MP)",
        "e164_key": "1-MP-0"
      },
      {
        "e164_cc": "47",
        "iso2_cc": "NO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Norway",
        "example": "41234567",
        "display_name": "Norway (NO) [+47]",
        "full_example_with_plus_sign": "+4741234567",
        "display_name_no_e164_cc": "Norway (NO)",
        "e164_key": "47-NO-0"
      },
      {
        "e164_cc": "968",
        "iso2_cc": "OM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Oman",
        "example": "92123456",
        "display_name": "Oman (OM) [+968]",
        "full_example_with_plus_sign": "+96892123456",
        "display_name_no_e164_cc": "Oman (OM)",
        "e164_key": "968-OM-0"
      },
      {
        "e164_cc": "92",
        "iso2_cc": "PK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Pakistan",
        "example": "3012345678",
        "display_name": "Pakistan (PK) [+92]",
        "full_example_with_plus_sign": "+923012345678",
        "display_name_no_e164_cc": "Pakistan (PK)",
        "e164_key": "92-PK-0"
      },
      {
        "e164_cc": "680",
        "iso2_cc": "PW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Palau",
        "example": "6201234",
        "display_name": "Palau (PW) [+680]",
        "full_example_with_plus_sign": "+6806201234",
        "display_name_no_e164_cc": "Palau (PW)",
        "e164_key": "680-PW-0"
      },
      {
        "e164_cc": "970",
        "iso2_cc": "PS",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Palestinian Territories",
        "example": "599123456",
        "display_name": "Palestinian Territories (PS) [+970]",
        "full_example_with_plus_sign": "+970599123456",
        "display_name_no_e164_cc": "Palestinian Territories (PS)",
        "e164_key": "970-PS-0"
      },
      {
        "e164_cc": "507",
        "iso2_cc": "PA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Panama",
        "example": "60012345",
        "display_name": "Panama (PA) [+507]",
        "full_example_with_plus_sign": "+50760012345",
        "display_name_no_e164_cc": "Panama (PA)",
        "e164_key": "507-PA-0"
      },
      {
        "e164_cc": "675",
        "iso2_cc": "PG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Papua New Guinea",
        "example": "6812345",
        "display_name": "Papua New Guinea (PG) [+675]",
        "full_example_with_plus_sign": "+6756812345",
        "display_name_no_e164_cc": "Papua New Guinea (PG)",
        "e164_key": "675-PG-0"
      },
      {
        "e164_cc": "595",
        "iso2_cc": "PY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Paraguay",
        "example": "961456789",
        "display_name": "Paraguay (PY) [+595]",
        "full_example_with_plus_sign": "+595961456789",
        "display_name_no_e164_cc": "Paraguay (PY)",
        "e164_key": "595-PY-0"
      },
      {
        "e164_cc": "51",
        "iso2_cc": "PE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Peru",
        "example": "912345678",
        "display_name": "Peru (PE) [+51]",
        "full_example_with_plus_sign": "+51912345678",
        "display_name_no_e164_cc": "Peru (PE)",
        "e164_key": "51-PE-0"
      },
      {
        "e164_cc": "63",
        "iso2_cc": "PH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Philippines",
        "example": "9051234567",
        "display_name": "Philippines (PH) [+63]",
        "full_example_with_plus_sign": "+639051234567",
        "display_name_no_e164_cc": "Philippines (PH)",
        "e164_key": "63-PH-0"
      },
      {
        "e164_cc": "48",
        "iso2_cc": "PL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Poland",
        "example": "512345678",
        "display_name": "Poland (PL) [+48]",
        "full_example_with_plus_sign": "+48512345678",
        "display_name_no_e164_cc": "Poland (PL)",
        "e164_key": "48-PL-0"
      },
      {
        "e164_cc": "351",
        "iso2_cc": "PT",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Portugal",
        "example": "912345678",
        "display_name": "Portugal (PT) [+351]",
        "full_example_with_plus_sign": "+351912345678",
        "display_name_no_e164_cc": "Portugal (PT)",
        "e164_key": "351-PT-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "PR",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Puerto Rico",
        "example": "7872345678",
        "display_name": "Puerto Rico (PR) [+1]",
        "full_example_with_plus_sign": "+17872345678",
        "display_name_no_e164_cc": "Puerto Rico (PR)",
        "e164_key": "1-PR-0"
      },
      {
        "e164_cc": "974",
        "iso2_cc": "QA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Qatar",
        "example": "33123456",
        "display_name": "Qatar (QA) [+974]",
        "full_example_with_plus_sign": "+97433123456",
        "display_name_no_e164_cc": "Qatar (QA)",
        "e164_key": "974-QA-0"
      },
      {
        "e164_cc": "262",
        "iso2_cc": "RE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Réunion",
        "example": "692123456",
        "display_name": "Réunion (RE) [+262]",
        "full_example_with_plus_sign": "+262692123456",
        "display_name_no_e164_cc": "Réunion (RE)",
        "e164_key": "262-RE-0"
      },
      {
        "e164_cc": "40",
        "iso2_cc": "RO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Romania",
        "example": "712345678",
        "display_name": "Romania (RO) [+40]",
        "full_example_with_plus_sign": "+40712345678",
        "display_name_no_e164_cc": "Romania (RO)",
        "e164_key": "40-RO-0"
      },
      {
        "e164_cc": "7",
        "iso2_cc": "RU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Russia",
        "example": "9123456789",
        "display_name": "Russia (RU) [+7]",
        "full_example_with_plus_sign": "+79123456789",
        "display_name_no_e164_cc": "Russia (RU)",
        "e164_key": "7-RU-0"
      },
      {
        "e164_cc": "250",
        "iso2_cc": "RW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Rwanda",
        "example": "720123456",
        "display_name": "Rwanda (RW) [+250]",
        "full_example_with_plus_sign": "+250720123456",
        "display_name_no_e164_cc": "Rwanda (RW)",
        "e164_key": "250-RW-0"
      },
      {
        "e164_cc": "590",
        "iso2_cc": "BL",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Saint Barthélemy",
        "example": "690221234",
        "display_name": "Saint Barthélemy (BL) [+590]",
        "full_example_with_plus_sign": "+590690221234",
        "display_name_no_e164_cc": "Saint Barthélemy (BL)",
        "e164_key": "590-BL-0"
      },
      {
        "e164_cc": "290",
        "iso2_cc": "SH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Saint Helena",
        "example": "",
        "display_name": "Saint Helena (SH) [+290]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Saint Helena (SH)",
        "e164_key": "290-SH-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "KN",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "St. Kitts",
        "example": "8695561234",
        "display_name": "St. Kitts (KN) [+1]",
        "full_example_with_plus_sign": "+18695561234",
        "display_name_no_e164_cc": "St. Kitts (KN)",
        "e164_key": "1-KN-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "LC",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "St. Lucia",
        "example": "7582845678",
        "display_name": "St. Lucia (LC) [+1]",
        "full_example_with_plus_sign": "+17582845678",
        "display_name_no_e164_cc": "St. Lucia (LC)",
        "e164_key": "1-LC-0"
      },
      {
        "e164_cc": "590",
        "iso2_cc": "MF",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Saint Martin",
        "example": "690221234",
        "display_name": "Saint Martin (MF) [+590]",
        "full_example_with_plus_sign": "+590690221234",
        "display_name_no_e164_cc": "Saint Martin (MF)",
        "e164_key": "590-MF-0"
      },
      {
        "e164_cc": "508",
        "iso2_cc": "PM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Saint Pierre and Miquelon",
        "example": "551234",
        "display_name": "Saint Pierre and Miquelon (PM) [+508]",
        "full_example_with_plus_sign": "+508551234",
        "display_name_no_e164_cc": "Saint Pierre and Miquelon (PM)",
        "e164_key": "508-PM-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "VC",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "St. Vincent",
        "example": "7844301234",
        "display_name": "St. Vincent (VC) [+1]",
        "full_example_with_plus_sign": "+17844301234",
        "display_name_no_e164_cc": "St. Vincent (VC)",
        "e164_key": "1-VC-0"
      },
      {
        "e164_cc": "685",
        "iso2_cc": "WS",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Samoa",
        "example": "601234",
        "display_name": "Samoa (WS) [+685]",
        "full_example_with_plus_sign": "+685601234",
        "display_name_no_e164_cc": "Samoa (WS)",
        "e164_key": "685-WS-0"
      },
      {
        "e164_cc": "378",
        "iso2_cc": "SM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "San Marino",
        "example": "66661212",
        "display_name": "San Marino (SM) [+378]",
        "full_example_with_plus_sign": "+37866661212",
        "display_name_no_e164_cc": "San Marino (SM)",
        "e164_key": "378-SM-0"
      },
      {
        "e164_cc": "239",
        "iso2_cc": "ST",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "São Tomé and Príncipe",
        "example": "9812345",
        "display_name": "São Tomé and Príncipe (ST) [+239]",
        "full_example_with_plus_sign": "+2399812345",
        "display_name_no_e164_cc": "São Tomé and Príncipe (ST)",
        "e164_key": "239-ST-0"
      },
      {
        "e164_cc": "966",
        "iso2_cc": "SA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Saudi Arabia",
        "example": "512345678",
        "display_name": "Saudi Arabia (SA) [+966]",
        "full_example_with_plus_sign": "+966512345678",
        "display_name_no_e164_cc": "Saudi Arabia (SA)",
        "e164_key": "966-SA-0"
      },
      {
        "e164_cc": "221",
        "iso2_cc": "SN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Senegal",
        "example": "701012345",
        "display_name": "Senegal (SN) [+221]",
        "full_example_with_plus_sign": "+221701012345",
        "display_name_no_e164_cc": "Senegal (SN)",
        "e164_key": "221-SN-0"
      },
      {
        "e164_cc": "381",
        "iso2_cc": "RS",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Serbia",
        "example": "601234567",
        "display_name": "Serbia (RS) [+381]",
        "full_example_with_plus_sign": "+381601234567",
        "display_name_no_e164_cc": "Serbia (RS)",
        "e164_key": "381-RS-0"
      },
      {
        "e164_cc": "248",
        "iso2_cc": "SC",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Seychelles",
        "example": "2510123",
        "display_name": "Seychelles (SC) [+248]",
        "full_example_with_plus_sign": "+2482510123",
        "display_name_no_e164_cc": "Seychelles (SC)",
        "e164_key": "248-SC-0"
      },
      {
        "e164_cc": "232",
        "iso2_cc": "SL",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Sierra Leone",
        "example": "25123456",
        "display_name": "Sierra Leone (SL) [+232]",
        "full_example_with_plus_sign": "+23225123456",
        "display_name_no_e164_cc": "Sierra Leone (SL)",
        "e164_key": "232-SL-0"
      },
      {
        "e164_cc": "65",
        "iso2_cc": "SG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Singapore",
        "example": "81234567",
        "display_name": "Singapore (SG) [+65]",
        "full_example_with_plus_sign": "+6581234567",
        "display_name_no_e164_cc": "Singapore (SG)",
        "e164_key": "65-SG-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "SX",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Sint Maarten",
        "example": "7215205678",
        "display_name": "Sint Maarten (SX) [+1]",
        "full_example_with_plus_sign": "+17215205678",
        "display_name_no_e164_cc": "Sint Maarten (SX)",
        "e164_key": "1-SX-0"
      },
      {
        "e164_cc": "421",
        "iso2_cc": "SK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Slovakia",
        "example": "912123456",
        "display_name": "Slovakia (SK) [+421]",
        "full_example_with_plus_sign": "+421912123456",
        "display_name_no_e164_cc": "Slovakia (SK)",
        "e164_key": "421-SK-0"
      },
      {
        "e164_cc": "386",
        "iso2_cc": "SI",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Slovenia",
        "example": "31234567",
        "display_name": "Slovenia (SI) [+386]",
        "full_example_with_plus_sign": "+38631234567",
        "display_name_no_e164_cc": "Slovenia (SI)",
        "e164_key": "386-SI-0"
      },
      {
        "e164_cc": "677",
        "iso2_cc": "SB",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Solomon Islands",
        "example": "7421234",
        "display_name": "Solomon Islands (SB) [+677]",
        "full_example_with_plus_sign": "+6777421234",
        "display_name_no_e164_cc": "Solomon Islands (SB)",
        "e164_key": "677-SB-0"
      },
      {
        "e164_cc": "252",
        "iso2_cc": "SO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Somalia",
        "example": "90792024",
        "display_name": "Somalia (SO) [+252]",
        "full_example_with_plus_sign": "+25290792024",
        "display_name_no_e164_cc": "Somalia (SO)",
        "e164_key": "252-SO-0"
      },
      {
        "e164_cc": "27",
        "iso2_cc": "ZA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "South Africa",
        "example": "711234567",
        "display_name": "South Africa (ZA) [+27]",
        "full_example_with_plus_sign": "+27711234567",
        "display_name_no_e164_cc": "South Africa (ZA)",
        "e164_key": "27-ZA-0"
      },
      {
        "e164_cc": "500",
        "iso2_cc": "GS",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "South Georgia and the South Sandwich Islands",
        "example": "",
        "display_name":
            "South Georgia and the South Sandwich Islands (GS) [+500]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc":
            "South Georgia and the South Sandwich Islands (GS)",
        "e164_key": "500-GS-0"
      },
      {
        "e164_cc": "82",
        "iso2_cc": "KR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "South Korea",
        "example": "1023456789",
        "display_name": "South Korea (KR) [+82]",
        "full_example_with_plus_sign": "+821023456789",
        "display_name_no_e164_cc": "South Korea (KR)",
        "e164_key": "82-KR-0"
      },
      {
        "e164_cc": "211",
        "iso2_cc": "SS",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "South Sudan",
        "example": "977123456",
        "display_name": "South Sudan (SS) [+211]",
        "full_example_with_plus_sign": "+211977123456",
        "display_name_no_e164_cc": "South Sudan (SS)",
        "e164_key": "211-SS-0"
      },
      {
        "e164_cc": "34",
        "iso2_cc": "ES",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Spain",
        "example": "612345678",
        "display_name": "Spain (ES) [+34]",
        "full_example_with_plus_sign": "+34612345678",
        "display_name_no_e164_cc": "Spain (ES)",
        "e164_key": "34-ES-0"
      },
      {
        "e164_cc": "94",
        "iso2_cc": "LK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Sri Lanka",
        "example": "712345678",
        "display_name": "Sri Lanka (LK) [+94]",
        "full_example_with_plus_sign": "+94712345678",
        "display_name_no_e164_cc": "Sri Lanka (LK)",
        "e164_key": "94-LK-0"
      },
      {
        "e164_cc": "249",
        "iso2_cc": "SD",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Sudan",
        "example": "911231234",
        "display_name": "Sudan (SD) [+249]",
        "full_example_with_plus_sign": "+249911231234",
        "display_name_no_e164_cc": "Sudan (SD)",
        "e164_key": "249-SD-0"
      },
      {
        "e164_cc": "597",
        "iso2_cc": "SR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Suriname",
        "example": "7412345",
        "display_name": "Suriname (SR) [+597]",
        "full_example_with_plus_sign": "+5977412345",
        "display_name_no_e164_cc": "Suriname (SR)",
        "e164_key": "597-SR-0"
      },
      {
        "e164_cc": "47",
        "iso2_cc": "SJ",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "Svalbard and Jan Mayen",
        "example": "41234567",
        "display_name": "Svalbard and Jan Mayen (SJ) [+47]",
        "full_example_with_plus_sign": "+4741234567",
        "display_name_no_e164_cc": "Svalbard and Jan Mayen (SJ)",
        "e164_key": "47-SJ-0"
      },
      {
        "e164_cc": "46",
        "iso2_cc": "SE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Sweden",
        "example": "701234567",
        "display_name": "Sweden (SE) [+46]",
        "full_example_with_plus_sign": "+46701234567",
        "display_name_no_e164_cc": "Sweden (SE)",
        "e164_key": "46-SE-0"
      },
      {
        "e164_cc": "41",
        "iso2_cc": "CH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Switzerland",
        "example": "741234567",
        "display_name": "Switzerland (CH) [+41]",
        "full_example_with_plus_sign": "+41741234567",
        "display_name_no_e164_cc": "Switzerland (CH)",
        "e164_key": "41-CH-0"
      },
      {
        "e164_cc": "963",
        "iso2_cc": "SY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Syria",
        "example": "944567890",
        "display_name": "Syria (SY) [+963]",
        "full_example_with_plus_sign": "+963944567890",
        "display_name_no_e164_cc": "Syria (SY)",
        "e164_key": "963-SY-0"
      },
      {
        "e164_cc": "886",
        "iso2_cc": "TW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Taiwan",
        "example": "912345678",
        "display_name": "Taiwan (TW) [+886]",
        "full_example_with_plus_sign": "+886912345678",
        "display_name_no_e164_cc": "Taiwan (TW)",
        "e164_key": "886-TW-0"
      },
      {
        "e164_cc": "992",
        "iso2_cc": "TJ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Tajikistan",
        "example": "917123456",
        "display_name": "Tajikistan (TJ) [+992]",
        "full_example_with_plus_sign": "+992917123456",
        "display_name_no_e164_cc": "Tajikistan (TJ)",
        "e164_key": "992-TJ-0"
      },
      {
        "e164_cc": "255",
        "iso2_cc": "TZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Tanzania",
        "example": "612345678",
        "display_name": "Tanzania (TZ) [+255]",
        "full_example_with_plus_sign": "+255612345678",
        "display_name_no_e164_cc": "Tanzania (TZ)",
        "e164_key": "255-TZ-0"
      },
      {
        "e164_cc": "66",
        "iso2_cc": "TH",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Thailand",
        "example": "812345678",
        "display_name": "Thailand (TH) [+66]",
        "full_example_with_plus_sign": "+66812345678",
        "display_name_no_e164_cc": "Thailand (TH)",
        "e164_key": "66-TH-0"
      },
      {
        "e164_cc": "228",
        "iso2_cc": "TG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Togo",
        "example": "90112345",
        "display_name": "Togo (TG) [+228]",
        "full_example_with_plus_sign": "+22890112345",
        "display_name_no_e164_cc": "Togo (TG)",
        "e164_key": "228-TG-0"
      },
      {
        "e164_cc": "690",
        "iso2_cc": "TK",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Tokelau",
        "example": "5190",
        "display_name": "Tokelau (TK) [+690]",
        "full_example_with_plus_sign": "+6905190",
        "display_name_no_e164_cc": "Tokelau (TK)",
        "e164_key": "690-TK-0"
      },
      {
        "e164_cc": "676",
        "iso2_cc": "TO",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Tonga",
        "example": "7715123",
        "display_name": "Tonga (TO) [+676]",
        "full_example_with_plus_sign": "+6767715123",
        "display_name_no_e164_cc": "Tonga (TO)",
        "e164_key": "676-TO-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "TT",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Trinidad/Tobago",
        "example": "8682911234",
        "display_name": "Trinidad/Tobago (TT) [+1]",
        "full_example_with_plus_sign": "+18682911234",
        "display_name_no_e164_cc": "Trinidad/Tobago (TT)",
        "e164_key": "1-TT-0"
      },
      {
        "e164_cc": "216",
        "iso2_cc": "TN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Tunisia",
        "example": "20123456",
        "display_name": "Tunisia (TN) [+216]",
        "full_example_with_plus_sign": "+21620123456",
        "display_name_no_e164_cc": "Tunisia (TN)",
        "e164_key": "216-TN-0"
      },
      {
        "e164_cc": "90",
        "iso2_cc": "TR",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Turkey",
        "example": "5012345678",
        "display_name": "Turkey (TR) [+90]",
        "full_example_with_plus_sign": "+905012345678",
        "display_name_no_e164_cc": "Turkey (TR)",
        "e164_key": "90-TR-0"
      },
      {
        "e164_cc": "993",
        "iso2_cc": "TM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Turkmenistan",
        "example": "66123456",
        "display_name": "Turkmenistan (TM) [+993]",
        "full_example_with_plus_sign": "+99366123456",
        "display_name_no_e164_cc": "Turkmenistan (TM)",
        "e164_key": "993-TM-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "TC",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "Turks and Caicos Islands",
        "example": "6492311234",
        "display_name": "Turks and Caicos Islands (TC) [+1]",
        "full_example_with_plus_sign": "+16492311234",
        "display_name_no_e164_cc": "Turks and Caicos Islands (TC)",
        "e164_key": "1-TC-0"
      },
      {
        "e164_cc": "688",
        "iso2_cc": "TV",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Tuvalu",
        "example": "901234",
        "display_name": "Tuvalu (TV) [+688]",
        "full_example_with_plus_sign": "+688901234",
        "display_name_no_e164_cc": "Tuvalu (TV)",
        "e164_key": "688-TV-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "VI",
        "e164_sc": 0,
        "geographic": true,
        "level": 2,
        "name": "U.S. Virgin Islands",
        "example": "3406421234",
        "display_name": "U.S. Virgin Islands (VI) [+1]",
        "full_example_with_plus_sign": "+13406421234",
        "display_name_no_e164_cc": "U.S. Virgin Islands (VI)",
        "e164_key": "1-VI-0"
      },
      {
        "e164_cc": "256",
        "iso2_cc": "UG",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Uganda",
        "example": "712345678",
        "display_name": "Uganda (UG) [+256]",
        "full_example_with_plus_sign": "+256712345678",
        "display_name_no_e164_cc": "Uganda (UG)",
        "e164_key": "256-UG-0"
      },
      {
        "e164_cc": "380",
        "iso2_cc": "UA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Ukraine",
        "example": "391234567",
        "display_name": "Ukraine (UA) [+380]",
        "full_example_with_plus_sign": "+380391234567",
        "display_name_no_e164_cc": "Ukraine (UA)",
        "e164_key": "380-UA-0"
      },
      {
        "e164_cc": "971",
        "iso2_cc": "AE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "United Arab Emirates",
        "example": "501234567",
        "display_name": "United Arab Emirates (AE) [+971]",
        "full_example_with_plus_sign": "+971501234567",
        "display_name_no_e164_cc": "United Arab Emirates (AE)",
        "e164_key": "971-AE-0"
      },
      {
        "e164_cc": "44",
        "iso2_cc": "GB",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "United Kingdom",
        "example": "7400123456",
        "display_name": "United Kingdom (GB) [+44]",
        "full_example_with_plus_sign": "+447400123456",
        "display_name_no_e164_cc": "United Kingdom (GB)",
        "e164_key": "44-GB-0"
      },
      {
        "e164_cc": "1",
        "iso2_cc": "US",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "United States",
        "example": "2012345678",
        "display_name": "United States (US) [+1]",
        "full_example_with_plus_sign": "+12012345678",
        "display_name_no_e164_cc": "United States (US)",
        "e164_key": "1-US-0"
      },
      {
        "e164_cc": "598",
        "iso2_cc": "UY",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Uruguay",
        "example": "94231234",
        "display_name": "Uruguay (UY) [+598]",
        "full_example_with_plus_sign": "+59894231234",
        "display_name_no_e164_cc": "Uruguay (UY)",
        "e164_key": "598-UY-0"
      },
      {
        "e164_cc": "998",
        "iso2_cc": "UZ",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Uzbekistan",
        "example": "912345678",
        "display_name": "Uzbekistan (UZ) [+998]",
        "full_example_with_plus_sign": "+998912345678",
        "display_name_no_e164_cc": "Uzbekistan (UZ)",
        "e164_key": "998-UZ-0"
      },
      {
        "e164_cc": "678",
        "iso2_cc": "VU",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Vanuatu",
        "example": "5912345",
        "display_name": "Vanuatu (VU) [+678]",
        "full_example_with_plus_sign": "+6785912345",
        "display_name_no_e164_cc": "Vanuatu (VU)",
        "e164_key": "678-VU-0"
      },
      {
        "e164_cc": "379",
        "iso2_cc": "VA",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Vatican City",
        "example": "",
        "display_name": "Vatican City (VA) [+379]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Vatican City (VA)",
        "e164_key": "379-VA-0"
      },
      {
        "e164_cc": "58",
        "iso2_cc": "VE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Venezuela",
        "example": "4121234567",
        "display_name": "Venezuela (VE) [+58]",
        "full_example_with_plus_sign": "+584121234567",
        "display_name_no_e164_cc": "Venezuela (VE)",
        "e164_key": "58-VE-0"
      },
      {
        "e164_cc": "84",
        "iso2_cc": "VN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Vietnam",
        "example": "912345678",
        "display_name": "Vietnam (VN) [+84]",
        "full_example_with_plus_sign": "+84912345678",
        "display_name_no_e164_cc": "Vietnam (VN)",
        "e164_key": "84-VN-0"
      },
      {
        "e164_cc": "681",
        "iso2_cc": "WF",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Wallis and Futuna",
        "example": "501234",
        "display_name": "Wallis and Futuna (WF) [+681]",
        "full_example_with_plus_sign": "+681501234",
        "display_name_no_e164_cc": "Wallis and Futuna (WF)",
        "e164_key": "681-WF-0"
      },
      {
        "e164_cc": "212",
        "iso2_cc": "EH",
        "e164_sc": 0,
        "geographic": true,
        "level": 3,
        "name": "Western Sahara",
        "example": "",
        "display_name": "Western Sahara (EH) [+212]",
        "full_example_with_plus_sign": null,
        "display_name_no_e164_cc": "Western Sahara (EH)",
        "e164_key": "212-EH-0"
      },
      {
        "e164_cc": "967",
        "iso2_cc": "YE",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Yemen",
        "example": "712345678",
        "display_name": "Yemen (YE) [+967]",
        "full_example_with_plus_sign": "+967712345678",
        "display_name_no_e164_cc": "Yemen (YE)",
        "e164_key": "967-YE-0"
      },
      {
        "e164_cc": "260",
        "iso2_cc": "ZM",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Zambia",
        "example": "955123456",
        "display_name": "Zambia (ZM) [+260]",
        "full_example_with_plus_sign": "+260955123456",
        "display_name_no_e164_cc": "Zambia (ZM)",
        "e164_key": "260-ZM-0"
      },
      {
        "e164_cc": "263",
        "iso2_cc": "ZW",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "Zimbabwe",
        "example": "711234567",
        "display_name": "Zimbabwe (ZW) [+263]",
        "full_example_with_plus_sign": "+263711234567",
        "display_name_no_e164_cc": "Zimbabwe (ZW)",
        "e164_key": "263-ZW-0"
      }
    ];

    Map<String, dynamic> mapVal = {};

    for (var item in countryCodes) {
      String displayName = item['display_name'];
      if (displayName.contains(str)) {
        mapVal = item;
      }
    }

    print("emozi is ${countryCodeToEmoji(mapVal['iso2_cc'])}");

    return countryCodeToEmoji(mapVal['iso2_cc']);
    // setPetProtFlag(countryCodeToEmoji(mapVal['iso2_cc']));
  }

  String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  String petProtFlag = "🇬🇧";
  String petProtPhCode = "44";

  String petProtFlag2 = "🇬🇧";
  String petProtPhCode2 = "44";

  String petProtFlag3 = "🇬🇧";
  String petProtPhCode3 = "44";

  setPetProtFlag(
    String flg,
  ) {
    // xtraPhNumlist[index].cntyflag=flg;
    // petProtFlag = flg;
    print("AFTER FINAL VALUE SET flag==***==>>${flg}");
    notifyListeners();
  }

  setPetProtPhCode(String pcode) {
    petProtPhCode = pcode;
    print("AFTER FINAL VALUE SET==>>${petProtPhCode}");
    notifyListeners();
  }

  // setPetProtFlag2(String flg) {
  //   petProtFlag2 = flg;
  //   print("AFTER FINAL VALUE SET flag==>>${petProtFlag2}");
  //   notifyListeners();
  // }

  // setPetProtPhCode2(String pcode) {
  //   petProtPhCode2 = pcode;
  //   print("AFTER FINAL VALUE SET==>>${petProtPhCode2}");
  //   notifyListeners();
  // }

  // setPetProtFlag3(String flg) {
  //   petProtFlag3 = flg;
  //   print("AFTER FINAL VALUE SET flag==>>${petProtFlag3}");
  //   notifyListeners();
  // }

  // setPetProtPhCode3(String pcode) {
  //   petProtPhCode3 = pcode;
  //   print("AFTER FINAL VALUE SET==>>${petProtPhCode3}");
  //   notifyListeners();
  // }

  String? repeatValSet;
  int? repeatType;

  setValue(String str1) {
    print("repeatttt=<${str1}");
    switch (str1) {
      case "Repeat.everymonth":
        petRepeatEvent.text = "Every Month";
        repeatType = 3;
        print("repeat time===>${repeatType}");

        break;

      case "Repeat.everyday":
        petRepeatEvent.text = "Every Day";
        repeatType = 1;
        print("repeat time===>${repeatType}");
        break;

      case "Repeat.everyyear":
        petRepeatEvent.text = "Every Year";
        repeatType = 4;
        print("repeat time===>${repeatType}");
        break;

      case "Repeat.everyweek":
        petRepeatEvent.text = "Every Week";
        repeatType = 2;
        print("repeat time===>${repeatType}");
        break;

      case "Repeat.never":
        petRepeatEvent.text = "Never";
        repeatType = 0;
        print("repeat time===>${repeatType}");
        break;

      default:
        petRepeatEvent.text = "Never";
        repeatType = 0;
        print("repeat time===>${repeatType}");
        break;
    }
    notifyListeners();
  }

  String? remindValSet;
  int? remindType;

  setRemindVal(String str1) {
    print("str1 value==>${str1}");
    switch (str1) {
      case "RemindTime.Min30":
        remindType = 2;
        print("remind time===>${remindType}");
        break;

      case "RemindTime.Min15":
        remindType = 1;
        print("remind time===>${remindType}");
        break;

      case "RemindTime.Hour1":
        remindType = 3;
        print("remind time===>${remindType}");
        break;

      case "RemindTime.Hour12":
        remindType = 4;
        print("remind time===>${remindType}");
        break;

      case "RemindTime.Hour24":
        remindType = 5;
        print("remind time===>${remindType}");
        break;

      case "RemindTime.never":
        remindType = 0;
        print("remind time===>${remindType}");
        break;

      default:
        remindType = 0;
        print("remind time===>${remindType}");
        break;
    }
  }

  getSetRemName(int rName) {
    RemindTime setRemind;
    switch (rName) {
      case 0:
        setRemind = RemindTime.never;
        editRemindBefor.text = "Off";
        break;

      case 1:
        setRemind = RemindTime.Min15;
        editRemindBefor.text = "15 Minutes";
        break;

      case 2:
        setRemind = RemindTime.Min30;
        editRemindBefor.text = "30 Minutes";
        break;

      case 3:
        setRemind = RemindTime.Hour1;
        editRemindBefor.text = "1 Hour";
        break;

      case 4:
        setRemind = RemindTime.Hour12;
        editRemindBefor.text = "12 Hour";
        break;

      case 5:
        setRemind = RemindTime.Hour24;
        editRemindBefor.text = "24 Hour";
        break;

      default:
        setRemind = RemindTime.never;
        editRemindBefor.text = "Off";
    }

    print("setRemindsetRemind${setRemind}");

    setReTime(setRemind);
  }

  getSetRepetNme(int rName) {
    Repeat setRepet;
    switch (rName) {
      case 0:
        setRepet = Repeat.never;
        editpetRepeatEvent.text = "Never";
        break;

      case 1:
        setRepet = Repeat.everyday;
        editpetRepeatEvent.text = "Every Day";
        break;

      case 2:
        setRepet = Repeat.everyweek;
        editpetRepeatEvent.text = "Every Week";
        break;

      case 3:
        setRepet = Repeat.everymonth;
        editpetRepeatEvent.text = "Every Month";
        break;

      case 4:
        setRepet = Repeat.everyyear;
        editpetRepeatEvent.text = "Every Year";
        break;

      default:
        setRepet = Repeat.never;
        editpetRepeatEvent.text = "Never";
    }

    setRepeat(setRepet);
  }

  int getMonth(String start) {
    var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
    int convertedDateTime = now.month;
    return convertedDateTime;
  }

  int getYear(String start) {
    var now = DateTime.fromMillisecondsSinceEpoch(int.parse(start));
    int convertedDateTime = now.year;
    return convertedDateTime;
  }

  DateTime formatDateTym2(String str) {
    if (str.isNotEmpty) {
      var now = DateTime.fromMillisecondsSinceEpoch(int.parse(str));
      // String convertedDateTime = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()} ";
      return now;
    } else {
      return DateTime.now();
    }

    // return convertedDateTime;
  }

  void checkIsPartOfList(DateTime selDate) {
    int isInList = 0;
    for (int i = 0; i < days.length; i++) {
      String str1 = days[i].toString();
      str1 = str1.substring(0, 10);
      print("str1 val=> ${str1}");
      if (DateFormat('yyyy-MM-dd').format(selDate).toString() == str1) {
        print("this is part of range");
        isInList = 1;
        // evtShowList=eventP2List.where((element) => DateFormat('yyyy-MM-dd').format(selDate).toString() ==str1).toList();
      } else {
        // evtShowList=[];
      }
    }
    print("isInList ${isInList}");

    if (isInList == -0) {
      evtShowList = [];
    }
    if (isInList == -1) {
      evtShowList = eventP2List;
    }
  }

  List<newButton> premiumbutton = [
    newButton(name: "Monthly Plans"),
    newButton(name: "Yearly Plans"),
    newButton(name: "Family Plans"),
  ];

  void updateSelectedContainer(int i) {
    BuildContext context = GlobalVariable.navState.currentContext!;
    for (var item in premiumbutton) {
      item.buttonisSelected = false;
    }
    premiumbutton[i].buttonisSelected = true;
    context.read<PurChaseProvider>().updateSelectedPlan(i);
    print("selected value is ${i}");

  }

  int planShow = 0;
  void showPlan(int i) {
    planShow = i;
    print("value of paln show===${planShow}");
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  List<premiumPlans> premiumPlanTitleList = [
    premiumPlans(name: "User Up To 1", id: 1, isSelected: true, showTick: 1),
    premiumPlans(
        name: "SMS Notifications", id: 2, isSelected: false, showTick: 0),
    premiumPlans(
        name: "Lifetime Pet Profile", id: 3, isSelected: true, showTick: 1),
    premiumPlans(
        name: "Additional Contacts", id: 4, isSelected: false, showTick: 1),
    premiumPlans(
        name: "Pictures, Documents", id: 5, isSelected: true, showTick: 0),
    premiumPlans(
        name: "Messenger FB, Whatsapp", id: 6, isSelected: false, showTick: 1),
    premiumPlans(
        name: "Multiple Pet Profiles", id: 7, isSelected: true, showTick: 1),
    premiumPlans(name: "Weight Tracker", id: 8, isSelected: false, showTick: 1),
    premiumPlans(
        name: "Free QR Tag Every Year", id: 9, isSelected: true, showTick: 1),
    premiumPlans(
        name: "Joint Management", id: 10, isSelected: false, showTick: 0),
    premiumPlans(
        name: "Add Family Member", id: 11, isSelected: true, showTick: 1),
    premiumPlans(name: "Multilingual", id: 12, isSelected: false, showTick: 1),
  ];

  List<int> monthly = [5,6,7];
  List<int> yearly = [7];
  List<int> family = [];

  int isSheildComplete = 0;

  setSheildStatus(int i) {
    Future.delayed(Duration.zero, () async {
      isSheildComplete = i;
      print("isSheildComplete===>> ${isSheildComplete}");
      notifyListeners();
    });
  }

  isShowSheild() {
    print("inside function=======");

    UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;
    var usrGen = 0;
    print("gender====${user.gender}");
    if (user.gender == "1" || user.gender == "2") {
      usrGen = 1;
    }
    print("usrGen===${usrGen}");
    if (selectedPetDetail?.petName == "" ||
        selectedPetDetail?.birthDate == "" ||
        selectedPetDetail?.color == "" ||
        selectedPetDetail?.gender == "" ||
        selectedPetDetail?.breedName == "" ||
        selectedPetDetail?.sterilization != "1" ||
        user.name == "" ||
        usrGen == 0 ||
        user.country == " " ||
        selectedPetDetail?.isPetQrCount == 0 ||
        selectedPetDetail?.microchip == "") {
      print("==========few feild are empty=======");
      setSheildStatus(0);
      print("==========value of is sheild compelete=======${isSheildComplete}");
    } else {
      setSheildStatus(1);
      print("==========all feild are full=======");
      print("==========value of is sheild compelete=======${isSheildComplete}");
    }
  }

  int isUserPremium = 0;

  setUserPremium() {
    isUserPremium = 1;
    notifyListeners();
  }

  var usrCode;

  setUsrCode(String str1) {
    Future.delayed(Duration.zero, () async {
      usrCode = str1;
      print("usrCode===>> ${usrCode}");
      notifyListeners();
    });
  }



   var openOnce=0;
   var callContactApi=0;


   int eventButton=0;
   void enableEntButton(){
     eventButton=1;
     notifyListeners();
   }

   int AddPetButton=0;
   void enableAddPetButton(){
     AddPetButton=1;
     notifyListeners();
   }


   bool petPreVal=false;
   changePetPremVal(){
     petPreVal=!petPreVal;
     notifyListeners();
     print("value after change====${petPreVal}");
   }


   int PetStatusval=0;

   int valChange=0;

   setPetStatusVal(){
     valChange=1;
     if(petPreVal==false){
       PetStatusval=0;
     }else{
       PetStatusval=1;

     }
     print("PetStatusval=====>${PetStatusval}");
     notifyListeners();
   }

   int? addPremPet;
   bool addPetChackVal=false;
  changePetPremAdd(){
    addPetChackVal=!addPetChackVal;
    notifyListeners();
    print("value after change====${addPetChackVal}");
  }

  changeAddPetChackVal(){

     print("addPetChackVal--->${addPetChackVal}");
     if(addPetChackVal){
       addPremPet=1;
     }else{
       addPremPet=0;
     }
   }


  // addPetPremApiCall() async {
  //   updateLoader(true);
  //   await api.setPetPremApi(
  //       {
  //         "petId":"",
  //         "status": addPremPet
  //       }
  //   ).then((value) async {
  //     if (value.status == Status.success) {
  //       print("api successsssssss");
  //       updateLoader(false);
  //       Future.delayed(const Duration(milliseconds: 400), () async {
  //         await getAllPet();
  //       });
  //       print("api enddddd======");
  //     }
  //   }).onError((error, stackTrace) {
  //     updateLoader(false);
  //
  //   });
  // }





}
