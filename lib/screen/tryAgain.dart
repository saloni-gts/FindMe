import 'package:flutter/material.dart';


import '../components/globalnavigatorkey.dart';
import '../components/homeLocPrem.dart';
import '../monish/screen/buyPremium.dart';
import '../util/color.dart';


Future<void> TryAgainAlert(BuildContext context,) async {
  await showDialog(

      context: context,
      builder: (context) => Center(
        child: Container(
          height: 40,
          color: Colors.black54,
          child:
             InkWell(
               onTap: (){
                 _onToastClicked();
               },
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Try Again!",
                 style: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.bold
                 ),

                 ),
               ),
             )
        ),
      )


      //     AlertDialog(
      //   elevation: 20,
      //
      //   backgroundColor: Colors.black54,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(32.0))),
      //
      //   actions:
      //
      //
      //
      //   <Widget>[
      //
      //    InkWell(
      //      onTap: (){
      //        _onToastClicked();
      //      },
      //      child: Text("Try Again!"),
      //    )
      //
      //
      //
      //
      //
      //
      //   ],
      //
      //
      // )
  );
}

  Future<void> _onToastClicked() async {
Navigator.pop(GlobalVariable.navState.currentContext!);
onNotification();

// await checkFinal(GlobalVariable.navState.currentContext!);
  }










