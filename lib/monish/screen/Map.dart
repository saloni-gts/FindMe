import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/monish/models/Locationlist.dart';
import 'package:find_me/monish/provider/mapProvider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/util/app_images.dart';
import 'package:find_me/util/color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/appbarComp.dart';
import '../../components/bottomBorderComp.dart';
import '../../generated/locale_keys.g.dart';
import '../../util/app_font.dart';
import '../reUseClass/Upcoming list.dart';
import '../reUseClass/myappbar.dart';

class Googlemap extends StatefulWidget {
  
  const Googlemap({
    Key? key,
  }) : super(key: key);

  @override
  State<Googlemap> createState() => _GooglemapState();
}

class _GooglemapState extends State<Googlemap> {
  late MapProvider mapProvider;
  var lati;
  var longi;

  final Completer<GoogleMapController> _conroller = Completer();

  late PetProvider petProvider1;
  bool loaderlisten1 = false;
  @override
  void initState() {
    petProvider1 = Provider.of(context, listen: false);
    mapProvider = Provider.of(context, listen: false);

    petProvider1.updateLoaderListen(loaderlisten1);
    // print("------------>>>>>  ${petProvider1.locationList[0].longitude}");
    // lati=petProvider1.locationList[0].latitude??"";
    // longi=petProvider1.locationList[0].longitude??"";
    print("********** latitiude ${lati}");
    print("********** longitude ${longi}");
    getLocation();

    loader();
    super.initState();
  }

  loader() {
    if (mapProvider.kGooglePlex == null) {
      loaderlisten1 = true;
    }
  }

  Future getLocation() async {
    await petProvider1.locationListCall(context).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        titlename: tr(LocaleKeys.additionText_QrtgRec),

      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: BotttomBorder(context),

      // bottomNavigationBar: BotttomBorder(context),
      body: Consumer2<PetProvider, MapProvider>(
          builder: (context, petProvider, value, child) {
        List<LocationListDetails> LocList = petProvider.locationList;
        Set<Marker> _markers = value.markers;
        print("C${LocList.length}");
        print("mmmm${_markers.length}");
        return Padding(
          padding: const EdgeInsets.all(13),
          child: value.kGooglePlex != null
              ? Column(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            GoogleMap(
                             // compassEnabled: true,
                              markers: value.markers,
                              mapType: MapType.normal,
                              initialCameraPosition: value.kGooglePlex!,
                              zoomControlsEnabled: false,

                              onMapCreated: (GoogleMapController controller) {
                                _conroller.complete(controller);

                                setState(() {});
                              },
                               myLocationEnabled: false,
                             myLocationButtonEnabled: false,

                            ),

                            Positioned(
                                bottom: 10,
                                right: 10,
                                child:
                            InkWell(
                              onTap: (){
                                if(lati==null && longi==null){
                                  print("--------null--------");
                                  lati=petProvider.locationList[0].latitude;
                                  longi=petProvider.locationList[0].longitude;
                                  print("--------${lati}--------");
                                  print("--------${longi}--------");
                                }
                                openMap(lati,longi);
                              },
                              child:
                                CircleAvatar(
                                  backgroundColor:AppColor.textRed,
                                  child: Image.asset(AppImage.groupIcon)
                                )
                            )
                            )

                          ],
                        )
                    ),


                    SizedBox(
                      height: 20.0,
                    ),

                    Expanded(
                      flex: 0,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          tr(LocaleKeys.additionText_scanHis),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: AppFont.poppinsMedium,
                              fontSize: 12,
                              color: Color(0xffBFBFBF)),
                        ),
                      ),
                    ),

                    SizedBox(
                      height:5.0,
                    ),

                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: ListView.builder(
                     //     reverse: true,
                              shrinkWrap: true,
                              itemCount: LocList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {

                                    lati=LocList[index].latitude;
                                    longi=LocList[index].longitude;


                                    print(" lati==== ${LocList[index].latitude}");
                                    print(" longi==== ${LocList[index].longitude}");

                                    showPin(
                                      double.parse(
                                          LocList[index].latitude.toString()),
                                      double.parse(
                                          LocList[index].longitude.toString()),
                                    );
                                  },
                                  child: upcommingListContainer(
                                    context,
                                    LocList[index],
                                  ),
                                );
                              }
                              ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: loader()),
        );
      }),
    );
  }

  Future<void> showPin(double lat, double long) async {
    GoogleMapController controller = await _conroller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(lat, long), zoom: 15, bearing: 45.0, tilt: 45.0),
    ));
  }

  void openMap(lati, longi) async{


    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lati,$longi';

    if(Platform.isIOS){
      if (await canLaunchUrlString(googleUrl)){
        await launchUrlString(googleUrl,mode:LaunchMode.externalApplication);
      }
    }
    else if(Platform.isAndroid){
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      }
    }


    else {
   print('Could not open the map.');
    }


  }



}
