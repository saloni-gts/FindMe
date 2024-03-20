import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/appbarComp.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/bottomBorderComp.dart';
import '../components/camraOption.dart';
import '../components/commingSoonAlert.dart';
import '../components/makePetprem.dart';
import '../components/newPreview.dart';
import '../components/previewFullImage.dart';
import '../components/shortpage.dart';
import '../generated/locale_keys.g.dart';
import '../models/getPhotosModel.dart';
import '../models/usermodel.dart';
import '../provider/petprovider.dart';
import '../services/hive_handler.dart';
import '../util/app_font.dart';
import '../util/appstrings.dart';
import '../util/color.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({Key? key}) : super(key: key);

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  @override
  void initState() {
    PetProvider petProvider = Provider.of(context, listen: false);
    print("petProvider.isUserPremium${petProvider.isUserPremium}");
    super.initState();
  }

  UserModel user = HiveHandler.getUserHiveRefresher().value.values.first;
  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, child) {
        var imgList = petProvider.images;

        return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // imgList.length >=2 && petProvider.isUserPremium ==0 ?SizedBox():

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0, left: 20),
                      child: FloatingActionButton(
                          backgroundColor: AppColor.newBlueGrey,
                          onPressed: () {
                            print("petProvider.isUserPremium:: ${petProvider.isUserPremium}");
                            print(
                                "petProvider.selectedPetDetail?.isPremium:: ${petProvider.selectedPetDetail?.isPremium}");
                            print("imgList.length:: ${imgList.length}");
                            if (petProvider.isUserPremium == 1 &&
                                petProvider.selectedPetDetail?.isPremium == 0 &&
                                imgList.length >= 2) {
                              makePetPremDialog(context);
                            } else if (imgList.length >= 2 && petProvider.isUserPremium == 0) {
                              commingSoonDialog(context, isFullAccess: 1);
                            } else if ((petProvider.isUserPremium == 1 &&
                                    petProvider.selectedPetDetail?.isPremium == 1) ||
                                petProvider.sharedPremIds.contains(petProvider.selectedPetDetail?.id)) {
                              showAlertForImage(
                                headText: tr(LocaleKeys.additionText_petName),
                                callBack: (val) {
                                  Navigator.pop(context);
                                  if (val) {
                                    getImage(ImageSource.camera, circleCropStyle: false).then((value) {
                                      print("value==$value");
                                      if (value.toString() == "File: ''") {
                                        print("value like this===");
                                        value = null;
                                      }

                                      if (value != null) {
                                        petProvider.uploadImagePet(f1: value, contxt: context);
                                      }
                                      print("********$val********-------+++++");
                                    });
                                  } else {
                                    getImage(ImageSource.gallery, circleCropStyle: false).then((value) {
                                      print("value==$value");
                                      if (value.toString() == "File: ''") {
                                        print("value like this===");
                                        value = null;
                                      }

                                      if (value != null) {
                                        petProvider.uploadImagePet(f1: value, contxt: context);
                                      }
                                    });
                                  }
                                },
                                context: context,
                              );
                            } else {
                              showAlertForImage(
                                headText: tr(LocaleKeys.additionText_petName),
                                callBack: (val) {
                                  Navigator.pop(context);
                                  if (val) {
                                    getImage(ImageSource.camera, circleCropStyle: false).then((value) {
                                      print("value==$value");
                                      if (value.toString() == "File: ''") {
                                        print("value like this===");
                                        value = null;
                                      }

                                      if (value != null) {
                                        petProvider.uploadImagePet(f1: value, contxt: context);
                                      }
                                      print("********$val********-------+++++");
                                    });
                                  } else {
                                    getImage(ImageSource.gallery, circleCropStyle: false).then((value) {
                                      print("value==$value");
                                      if (value.toString() == "File: ''") {
                                        print("value like this===");   
                                        value = null;  
                                      }   

                                      if (value != null) {    
                                        petProvider.uploadImagePet(f1: value, contxt: context);  
                                      }  
                                    });  
                                  }
                                },
                                context: context,
                              );
                            }
                            //callUploadPetImage()
                          },
                          child: const Icon(Icons.add)),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                BotttomBorder(context),
              ],
            ),
            backgroundColor: Colors.white,
            // bottomNavigationBar: BotttomBorder(context),
            appBar: customAppbar(titlename: tr(LocaleKeys.additionText_photoGallery)),
            body: imgList.isEmpty
                ? Center(
                    child: Text(
                      tr(LocaleKeys.additionText_galleryisEmpty),
                      // tr(LocaleKeys.additionText_editNote),
                      style: const TextStyle(
                          fontSize: 18.0, color: AppColor.newBlueGrey, fontFamily: AppFont.poppinSemibold),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: GridView.builder(
                        itemCount: imgList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,  
                          mainAxisExtent: 160,   
                          crossAxisSpacing: 0,    
                          mainAxisSpacing: 9,  
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              petdeleteDailog(context: context, imgData: imgList[index]);
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PreviewFullImage(imgData:imgList[index])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 5, right: 8, left: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: SizedBox(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width * .45,
                                  child: CachedNetworkImage(
                                    imageUrl: imgList[index].photo ?? "",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ));
      },
    );
  }
}
