import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/screen/editHealthCard.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/healthCardContainer.dart';
import '../generated/locale_keys.g.dart';
import '../util/app_font.dart';

class ViewHealthCard extends StatefulWidget {

   ViewHealthCard({Key? key,}) : super(key: key);

  @override
  State<ViewHealthCard> createState() => _ViewHealthCardState();
}

class _ViewHealthCardState extends State<ViewHealthCard> {
  @override

  void initState(){

    PetProvider petProvider=Provider.of(context,listen: false);

    petProvider.callGetAllPetHealthApi(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context,petProvider,child) {
        List cardList= petProvider.PetallHlthCard;
        return Scaffold(
          
          // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 10.0),
          //   child: BotttomBorder(context),
          // ),
          // bottomNavigationBar: BotttomBorder(context),

          backgroundColor: Colors.white,
          body:
          cardList.isEmpty?

          Center(
            child: Text(
              tr(LocaleKeys.additionText_NohlthCardFnd),
              style: TextStyle(
                  fontSize: 18.0,
                  color: AppColor.textLightBlueBlack,
                  fontFamily: AppFont.poppinSemibold),
            ),
          )
              :
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ListView.builder(
                itemCount: cardList.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                         onTap: (){

                           print("printing hte value  of id===>>> ${cardList[index].id}");
                           petProvider.setCardID(cardList[index].id);
                           petProvider.setSelectedCard(cardList[index]);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditHealthCard()));
                         },

                        child: HealthCardContainer(context,cardList[index])),
                  );
                }


            ),
          )




        );
      }
    );
  }
}
