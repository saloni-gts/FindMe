import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:find_me/models/getPhotosModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../generated/locale_keys.g.dart';
import '../provider/petprovider.dart';
import '../util/app_images.dart';
import '../util/appstrings.dart';

class PreviewFullImage extends StatefulWidget {
  GetPetPhotos imgData;
  PreviewFullImage({Key? key,required this.imgData}) : super(key: key);

  @override
  State<PreviewFullImage> createState() => _PreviewFullImageState();
}

class _PreviewFullImageState extends State<PreviewFullImage> {

  Size get preferredSize => Size.fromHeight(55);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  AppImage.topBorder,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImage.topBorder,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Container(
                            width: 20,
                            child: Image.asset(AppImage.backArrow),
                          ),
                        ),


                        InkWell(

                          onTap: (){

                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title: Text(tr(LocaleKeys.additionText_sureWannaDel)),
                              actions: <Widget>[
                                InkWell(
                                  child:  Text(tr(LocaleKeys.additionText_cancel)),
                                  onTap: () {

                                    Navigator.of(context).pop();
                                  },
                                ),
                                InkWell(
                                  child: Text(tr(LocaleKeys.additionText_yes)),
                                  onTap: () async {

                                      PetProvider petProvider = Provider.of(context, listen: false);
                                      Map<String,dynamic> bodyy={
                                        "petId":widget.imgData.petId,
                                        "id":widget.imgData.id
                                      };
                                     await petProvider.deletePetPhotoCall(bodyy,context: context);
                                      Navigator.pop(context);


                                  },
                                )
                              ],
                            )
                            );

                          },



                            //
                            // onTap: (){
                            //   PetProvider petProvider = Provider.of(context, listen: false);
                            //   Map<String,dynamic> bodyy={
                            //     "petId":widget.imgData.petId,
                            //     "id":widget.imgData.id
                            //   };
                            //   petProvider.deletePetPhotoCall(bodyy,context: context);
                            //   Navigator.pop(context);
                            //
                            // },
                            //


                            child: Image(image: AssetImage(AppImage.largeDeleteIcon))) ,

                        // IconButton(
                        //   icon: const Icon(Icons.more_horiz),
                        //   onPressed: () {
                        //
                        //      Container(
                        //        color: Colors.black,
                        //        child: ListTile(
                        //          leading: IconButton(
                        //            icon: Icon(Icons.delete),
                        //            onPressed: () {},
                        //          ),
                        //          title: Text("Delete"),
                        //
                        //        ),
                        //     );
                        //
                        //   },
                        //   color: Colors.black,
                        // )


                      ]),
                ))
          ],
        ),
      ),
      body: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                  widget.imgData.photo??""))),
    );
  }
}








class PreviewFullImage2 extends StatefulWidget {
  String docUrl;
  bool isImage;
  bool isBackButton;
  PreviewFullImage2({required this.docUrl, required this.isImage,this.isBackButton=true});



  @override
  State<PreviewFullImage2> createState() => _PreviewFullImage2State();
}

class _PreviewFullImage2State extends State<PreviewFullImage2> {


  Size get preferredSize => Size.fromHeight(55);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:customAppbar(isbackbutton: true),

      // AppBar(
      //   centerTitle: true,
      //   titleSpacing: 0.0,
      //   elevation: 0.0,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 5.0),
      //         child: Container(
      //           width: MediaQuery.of(context).size.width,
      //           child: Image.asset(
      //             AppImage.topBorder,
      //             fit: BoxFit.cover,
      //           ),
      //           decoration: BoxDecoration(
      //               image: DecorationImage(
      //                 image: AssetImage(
      //                   AppImage.topBorder,
      //                 ),
      //                 fit: BoxFit.cover,
      //               )),
      //         ),
      //       ),
      //       Container(
      //         child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //
      //               InkWell(
      //                 onTap: (){
      //                   Navigator.pop(context);
      //                 },
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                       vertical: 4.0, horizontal: 8.0),
      //                   child: Container(
      //                     width: 20,
      //                     child: Image.asset(AppImage.backArrow),
      //                   ),
      //                 ),
      //               ),
      //
      //
      //
      //             ]),
      //       )
      //     ],
      //   ),
      // ),


        body:widget.isImage? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
                imageUrl:  widget.docUrl,

            )):

      // body:widget.isImage? Container(
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     child: Image.network(
      //         widget.docUrl??"")):


        // PDFView(
        //     filePath:widget.docUrl,
        //    swipeHorizontal: true,
        // )
 
      PDF(
        swipeHorizontal: true,
      ).cachedFromUrl(widget.docUrl)

    );

  }
}






