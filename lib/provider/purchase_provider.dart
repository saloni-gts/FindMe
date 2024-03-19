import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/models/planApiMode.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_images.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


import '../../generated/locale_keys.g.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';


import '../api/call_api.dart';
import '../api/staus_enum.dart';
import '../components/globalnavigatorkey.dart';
import '../monish/models/newModel.dart';

enum planTypeEnum { month, year, family ,restore }

const monthySubscriptionAndroid = "basic_month";
const yearlySubscriptionAndroid = "popular_year";
const familyPlan = "family";

class PurchasableProduct {
  String get id => productDetails.id;
  String get title => productDetails.title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;
  PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;
 
}

enum ProductStatus {
  purchasable,
  purchased,
  pending,
}

class PurChaseProvider extends ChangeNotifier {
  /// 1 for month
  /// 2 for year
  /// 3 for family plan
  ///
  ///

  var isChoice;
  int isCalledApi = 0;
  bool isFromDashboard = false;
   bool isRestore=false;
  PetProvider pet =
      Provider.of(GlobalVariable.navState.currentContext!, listen: false);

  int ShowCurrentPlan = 0;

  setPlanVal(int val) {
    print("value of i==>${val}");
    ShowCurrentPlan = val;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  updateIsCalledApi(int val) async {
    isCalledApi = val;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  isFromInit(bool val) {
    isFromDashboard = val;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  updateIsRestor(bool isReset) async {
    isRestore=isReset;
    await Future.delayed(Duration(seconds: 0));
    notifyListeners();
  }

  AppApi api = AppApi();
  static InAppPurchase? inAppPurchaseConnection;
 
  List<PurchasableProduct> products = [];
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  int purchaseStatus = 0;
  int selectedPlan = 0;
  bool userIsPremium = false;
  List<PlansApiModel> planList = [];

  updateIsPremium(bool val) async {
    
    userIsPremium = val;
    Future.delayed(Duration(seconds: 0), () {
      notifyListeners();
    });
  }

  var isUsrJoint;
  var isPlanActive;

  List<Choice> choices = [];

  List<int> showPlan = [];
  int isfound = 0;

  // List<Choice> choices =[];

  List<Choice> choices1 = [
    Choice(
        title: tr(LocaleKeys.additionText_premiumSubscription),
        image: AssetImage(AppImage.premiumIcon),
        type: 13),
    Choice(
        title: tr(LocaleKeys.additionText_AddFamMember),
        image: AssetImage(AppImage.familyplanIcon),
        type: 1),
    Choice(
        title: tr(LocaleKeys.additionText_AddJointOnr),
        image: AssetImage(AppImage.addjoint),
        type: 4),
    Choice(
        title: tr(LocaleKeys.additionText_PndingReq),
        image: AssetImage(AppImage.pendinReq),
        type: 20),
    Choice(
        title: tr(LocaleKeys.moreFeatures_aboutUs),
        image: AssetImage(AppImage.aboutus),
        type: 2),
    Choice(
        title: tr(LocaleKeys.additionText_howitWrks),
        image: AssetImage(AppImage.howItWoks),
        type: 9),
    Choice(
        title: tr(LocaleKeys.moreFeatures_faq),
        image: AssetImage(AppImage.faqicon),
        type: 3),
    Choice(
        title: tr(LocaleKeys.moreFeatures_customerCare),
        image: AssetImage(AppImage.customer),
        type: 5),
    Choice(
        title: tr(LocaleKeys.additionText_RateUss),
        image: AssetImage(AppImage.rateus),
        type: 6),
    Choice(
      title: tr(LocaleKeys.additionText_ShareDApp),
      image: AssetImage(AppImage.shareicon1),
      type: 7,
    ),
    Choice(
        title: tr(LocaleKeys.moreFeatures_settings),
        image: AssetImage(AppImage.setting1),
        type: 8),
  ];

  List<Choice> choices2 = [
    Choice(
        title: tr(LocaleKeys.additionText_premiumSubscription),
        image: AssetImage(AppImage.premiumIcon),
        type: 13),
    Choice(
        title: tr(LocaleKeys.additionText_PndingReq),
        image: AssetImage(AppImage.pendinReq),
        type: 20),
    Choice(
        title: tr(LocaleKeys.moreFeatures_aboutUs),
        image: AssetImage(AppImage.aboutus),
        type: 2),
    Choice(
        title: tr(LocaleKeys.additionText_howitWrks),
        image: AssetImage(AppImage.howItWoks),
        type: 9),
    Choice(
        title: tr(LocaleKeys.moreFeatures_faq),
        image: AssetImage(AppImage.faqicon),
        type: 3),
    Choice(
        title: tr(LocaleKeys.moreFeatures_customerCare),
        image: AssetImage(AppImage.customer),
        type: 5),
    Choice(
        title: tr(LocaleKeys.additionText_RateUss),
        image: AssetImage(AppImage.rateus),
        type: 6),
    Choice(
      title: tr(LocaleKeys.additionText_ShareDApp),
      image: AssetImage(AppImage.shareicon1),
      type: 7,
    ),
    Choice(
        title: tr(LocaleKeys.moreFeatures_settings),
        image: AssetImage(AppImage.setting1),
        type: 8),
  ];

  List<int> plan = [];
  List<int> Multipleplan = [];

  int showYrlyList=0;


  Future getSubScriptionDetails() async {
    await api.getSubScriptonDetails().then((value) {
      if (value.status == Status.success) {
        PetProvider petProvider =
            Provider.of(GlobalVariable.navState.currentContext!, listen: false);

        planList = [];
        plan = [];
        showPlan = [];
        List temp = value.data['Plan'];

        if (temp.isNotEmpty) {
          print("list is not empty");

          if (temp.length == 1) {
            if (temp[0]["isPremium"] == 1) {
              pet.isUserPremium = 1;
            }
          }
          if (temp.length == 2) {
            if (temp[0]["isPremium"] == 1 || temp[1]["isPremium"] == 1) {
              pet.isUserPremium = 1;
            }

            List l1 = [];
            l1.add(temp[0]["planId"]);
            l1.add(temp[1]["planId"]);
            print("===2 element list========>>>${l1}");
          }
        } else {
          print("list is empty");
          pet.isUserPremium = 0;
          updateIsPremium(false);
          choices = choices2;
        }
        print("temp=======000${temp}");

        print("temp=======000===${pet.isUserPremium}");

        if (temp.isNotEmpty) {
          updateIsPremium(true);
          planList = List<PlansApiModel>.from(
              value.data['Plan'].map((x) => PlansApiModel.fromJson(x)));



          if(planList.isEmpty){
            choices=choices2;
            pet.isUserPremium=0;
          }

          print("planList.length===${planList.length}");
          // for(int i=0;i<planList.length;i++){
          //   if(planList[i].isJoint==1){
          //     choices= choices2;
          //
          //   }
          // }

          if (planList.isNotEmpty) {
            // getPlanId();
            int? a1 = planList[0].planId;
            int? b1 = planList[0].isPrremium;
            int? c1 = planList[0].isJoint;

            print("a1====plan id====${a1}");
            print("b1====isPremium====${b1}");
            print("c1====isJoint====${c1}");

            if (planList.length == 1) {
              if (planList[0].isPrremium == 1) {
                pet.isUserPremium = 1;
                int e1 = a1! - 1;
                if(c1==1){
                  plan.add(1);
                  showYrlyList=1;
                }else {

                  plan.add(e1);
                }
                showPlan.add(e1);
                print("showPlan====${showPlan}");
              } else {
                plan = [];
                showPlan = [];
              }
              if (b1 == 0) {
                choices = choices2;
                print("choices.lengeth======${choices.length}");
                notifyListeners();
              } else {
                isChoice = a1;
                print("isChoice==-=-=");
                if (c1 == 1) {
                  isChoice = 1;
                }
                choices = isChoice == 3 ? choices1 : choices2;
                print("choices.lengeth======${choices.length}");
                notifyListeners();
              }
            }

            // if(planList.length==2){
            //   if(planList[0].isPrremium==1||planList[1].isPrremium==1){
            //   plan.add(1);
            //   if(planList[0].isPrremium==1){
            //     int? f1=planList[0].planId;
            //     showPlan.add(f1!-1);
            //   }
            //   if(planList[1].isPrremium==1){
            //     int? f2=planList[1].planId;
            //     showPlan.add(f2!-1);
            //   }
            //   if(showPlan.length==2){
            //     int g1=showPlan[0];
            //     int g2=showPlan[1];
            //     showPlan.clear();
            //     if(g1>g2){
            //       showPlan.add(g1);
            //     }
            //     else if(g1<g2){
            //       showPlan.add(g2);
            //     }  else if(g1==g2){
            //       showPlan.add(g1);
            //     }
            //   }
            //   print("showPlan====${showPlan}");
            //   int? d1=planList[0].isJoint;
            //   int? d2=planList[1].isJoint;
            //
            //   if(d1==1||d2==1){
            //     choices=choices2;
            //     notifyListeners();
            //   }else{
            //     choices=choices2;
            //     notifyListeners();
            //   }
            //   }else{
            //     plan=[];
            //   }
            // }
            else if (planList.length >= 2) {
              Multipleplan = [];
              plan = [];
              showPlan=[];
              isfound = 0;

              for (int i = 0; i < planList.length; i++) {
                if (planList[i].isPrremium == 1) {
                  pet.isUserPremium = 1;
                }
              }


              if (isfound == 0) {
                print("inside this===3");
                for (int i = 0; i < planList.length; i++) {
                  if (planList[i].isJoint == 1 && planList[i].isPrremium == 1) {
                    print("inside this condi===3");
                    showYrlyList=1;
                    //show family plan and joint mgt and add family member all yearly plan features - off
                     showPlan=[];

                    showPlan.add(2);
                    plan.add(1);
                    choices = choices2;
                    isfound = 1;
                    if(plan.length>1){
                      print("check this condition");
                      Multipleplan=[];
                      for(int i=0;i<plan.length;i++){
                        Multipleplan.add(plan[i]);
                       }
                      plan=[];
                     int a= getPlanId();
                      plan.add(a);

                    }
                    print("==final plan list 3=====${plan}");
                    print("==final show list 3=====${showPlan}");
                    // return;
                  }
                }
                print("==final plan list====3=${plan}");
                print("==final show list===3==${showPlan}");
              }


              if (isfound == 0) {
                print("inside this===1");

                for (int i = 0; i < planList.length; i++) {
                  if (planList[i].isJoint == -1 &&
                      planList[i].planId == 3 &&
                      planList[i].isPrremium == 1) {
                    print("inside this condi===1");
                    //show family plan and joint mgt and add family member all family plan features- 0n
                    showPlan.add(2);
                    plan.add(2);
                    choices = choices1;
                    isfound = 1;
                  }
                  }
                if(plan.length>1){
                  print("check this condition");
                  Multipleplan=[];
                  for(int i=0;i<plan.length;i++){
                    Multipleplan.add(plan[i]);
                  }
                  plan=[];
                  int a= getPlanId();
                  plan.add(a);

                  showPlan.add(a);
                }
                print("==final plan list 1=====${plan}");
                print("==final show list 1=====${showPlan}");
              }

              if (isfound == 0) {
                print("inside this===2");
                for (int i = 0; i < planList.length; i++) {
                  if (planList[i].isJoint == -1 &&
                      planList[i].isPrremium == 1) {
                    print("inside this condi===2");
                    //show family plan and joint mgt and add family member all family plan features- 0n
                    // showPlan.add();
                    int? p1 = planList[i].planId;
                    int? q1 = p1! - 1;
                    Multipleplan.add(q1);
                    isfound = 1;
                  }
                }
                if (isfound == 1) {
                  int f1 = getPlanId();
                  plan.add(f1);
                  showPlan.add(f1);

                  if (f1 == 2) {
                    choices = choices1;
                  } else {
                    choices = choices2;
                  }
                }
                print("==final plan list 2=====${plan}");
                print("==final show list 2=====${showPlan}");
              }


            }

            print("==final plan list=====${plan}");
            print("==final show list=====${showPlan}");
          } else {
            choices = choices2;
            notifyListeners();
          }

          notifyListeners();
          print("planList=====${planList}");

          print("temp.length=${temp.length}");

          for (int i = 0; i < planList.length; i++) {
            print("====${temp[i]["planId"]}");

            // int a = temp[i]["planId"];
            isPlanActive = temp[i]["isPremium"];
            print(isPlanActive);

            if (isPlanActive == 1) {
              petProvider.setUserPremium();
              if (temp[i]["planId"] == 3) {
                isUsrJoint = temp[i]["isJoint"];
              }
            }
            if (isPlanActive != 1) {
              petProvider.isUserPremium = 0;
            }

            isUsrJoint = temp[i]["isJoint"];
            // int D = temp[i]["isJoint"];
            // print("a=====${a - 1}");
            // int b = a - 1;

            int a = temp[i]["planId"];
            int D = temp[i]["isJoint"];
            print("a=====${a - 1}");
            int b = a - 1;
            if (temp[i]["isPremium"] == 1) {
              // plan.add(b);
            }
            isChoice = plan[0];
            print("isChoice==-=-=");

            print("plan=${plan}");
            print("isUsrJoint=${isUsrJoint}");
          }
        } else {
          updateIsPremium(false);
        }
      }
    }).onError((error, stackTrace) {
      updateIsPremium(false);
    });
  }

  updateSelectedPlan(int val) {
    selectedPlan = val + 1;
    Future.delayed(Duration(seconds: 0), () {
      notifyListeners();
    });
  }

  Future initPurchaseData() async {
    inAppPurchaseConnection = InAppPurchase.instance;
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchaseConnection!.purchaseStream;
    await loadPurchase();

    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    try {
      print("purchaseDetailsList length >>>> ${purchaseDetailsList.length}");
      purchaseDetailsList.forEach(_handlePurchase);
    } catch (e) {
      print("Error Found on purchase process ${e}");
    }
    notifyListeners();
  }

  var CheckPurchased;

  Future<void> _handlePurchase(PurchaseDetails purchaseDetials) async {
    String payment_Status = "0";
    int value = 0;
    print("purchaseDetials status is ${purchaseDetials.status}");
    if (purchaseDetials.status == PurchaseStatus.purchased||purchaseDetials.status==PurchaseStatus.restored ) {
      switch (purchaseDetials.productID) {
        case monthySubscriptionAndroid:
          purchaseStatus = 1;
          value = 1;
          CheckPurchased = 1;
          break;
        case yearlySubscriptionAndroid:
        case "popular_yearly":
          purchaseStatus = 2;
          value = 2;
          CheckPurchased = 2;
          break;
        case familyPlan:
        case "family_premium":
          purchaseStatus = 3;
          value = 3;
          CheckPurchased = 3;
          break;
      }
    }
    if (purchaseDetials.pendingCompletePurchase) {
      print("call pending purchase complete");
      await inAppPurchaseConnection?.completePurchase(purchaseDetials);
    }

    print(
        "call api automaticaly ${purchaseDetials.productID} ${purchaseDetials.purchaseID} and value ${value}");
    if (value != 0) {
      _subscription.cancel();
      print("isFromDashboard value >>> 1 ${isFromDashboard}");
      // if(iscallApi==0) {
      if (isCalledApi == 0) {
        print("isFromDashboard======>${isFromDashboard}");
        updateIsCalledApi(1);
        api
            .updateSubscription(
                planId: value,
             
               receiptData:
                    purchaseDetials.verificationData.serverVerificationData,
                isRenewd: false)
            .then((value) async {
          if (!isFromDashboard) {
            if (value.status == Status.success) {
              EasyLoading.dismiss();
              CoolAlert.show(
                  context: GlobalVariable.navState.currentContext!,
                  type: CoolAlertType.success,
                  text: value.message);

              await getSubScriptionDetails();

              // Navigator.push(GlobalVariable.navState.currentContext!, MaterialPageRoute(builder: (context)=>PetProfile()));

              setPlanVal(1);
            } else {
              EasyLoading.dismiss();
              CoolAlert.show(
                  context: GlobalVariable.navState.currentContext!,
                  type: CoolAlertType.error,
                  text: value.message);
            }
          }
        }).onError((error, stackTrace) {
          EasyLoading.dismiss();
        });
      }

      // }iscallApi=1;

      /// call api
    }
  }

  Future<void> loadPurchase() async {
    final isAvaliable = await inAppPurchaseConnection?.isAvailable() ?? false;
    print("is Available $isAvaliable");
    if (!isAvaliable) {
      return;
    }

    var ids = <String>{
      monthySubscriptionAndroid,
      Platform.isAndroid ? yearlySubscriptionAndroid : "popular_yearly",
      Platform.isAndroid ? familyPlan : "family_premium"
    };

    ProductDetailsResponse? response =
        await inAppPurchaseConnection?.queryProductDetails(ids);

    products =
        response!.productDetails.map((e) => PurchasableProduct(e)).toList();
    print("length is ${products.length}");
    for (var item in products) {
        print("price::: ${item.productDetails.price}");
      // }
    }
    notifyListeners();
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    _subscription.cancel();
  }

  Future<void> buy(PurchasableProduct product) async {
    print("product id is ${product.id}");
    
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    print("application user name ${purchaseParam.applicationUserName}");
    switch (product.id) {
      case monthySubscriptionAndroid:
        await inAppPurchaseConnection?.buyNonConsumable(
            purchaseParam: purchaseParam);
        break;

      case yearlySubscriptionAndroid:
      case "popular_yearly":
        await inAppPurchaseConnection
            ?.buyNonConsumable(purchaseParam: purchaseParam)
            .catchError((error, stackTrace) {
          print("errror is ${error}");
        });
        break;
      case familyPlan:
      case "family_premium":
        await inAppPurchaseConnection?.buyNonConsumable(
            purchaseParam: purchaseParam);
        break;
      default:
        break;
    }
    inAppPurchaseConnection?.purchaseStream.listen((event) {
      event.forEach(((item) {
        print("purchase stream listter error ${item.error}");
        print("purchase stream listter status ${item.status}");
        print("purchase stream listter product id ${item.productID}");
        // print("purchase stream listter transation date ${item.transactionDate}");
        if (item.status == PurchaseStatus.canceled ||
            item.status == PurchaseStatus.purchased ||
            item.status == PurchaseStatus.error ||
            item.status == PurchaseStatus.restored) {
          EasyLoading.showToast(
            _getMessage(item.status),
            toastPosition: EasyLoadingToastPosition.center,
          );
          if (Platform.isIOS) {
            switch (item.status) {
              case PurchaseStatus.canceled:
                inAppPurchaseConnection?.completePurchase(item);

                break;

              case PurchaseStatus.pending:
                inAppPurchaseConnection?.completePurchase(item);
                break;
              case PurchaseStatus.purchased:
                inAppPurchaseConnection?.completePurchase(item);
                break;
              case PurchaseStatus.error:
                inAppPurchaseConnection?.completePurchase(item);
                break;
              case PurchaseStatus.restored:
                inAppPurchaseConnection?.completePurchase(item);
                break;
            }
          }

          // Fluttertoast.showToast(
          //
          //     msg: _getMessage(item.status),
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     // backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //
          //     fontSize: 16.0,
          //
          // );
        }
      }));
    });
  }

  Future<void> restorePurchase()async{
    
    print("call restore purpose");
    await inAppPurchaseConnection?.restorePurchases().onError((error, stackTrace) {
      print("error is ${error.toString()}");
    }).then((value) {
      print("call");
    });
  }


  String _getMessage(PurchaseStatus message) {
    switch (message) {
      case PurchaseStatus.pending:
        return "Payment is Pending";
      case PurchaseStatus.purchased:
        return "Purchased Succsess";
      case PurchaseStatus.error:
        return "Somthing went wrong";
      case PurchaseStatus.restored:
        return "Plan Restored";
      case PurchaseStatus.canceled:
        return "Purchase cancelled";
    }
  }

  int maxPlanId = 0;
  int getPlanId() {
// print("====plan==");
    // plan
    for (int i in Multipleplan) {
      if (i > maxPlanId) {
        maxPlanId = i;
      }
    }
    print("macPlanid===>${maxPlanId}");
    return maxPlanId;
  }
}
