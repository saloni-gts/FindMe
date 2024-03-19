import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';


import '../../generated/locale_keys.g.dart';

class MapProvider with ChangeNotifier {
  Set<Marker> markers = {};
  CameraPosition? kGooglePlex;
  bool loader = false;

  addMarker(BuildContext ctx) {
    PetProvider petProvider = Provider.of(ctx, listen: false);

    for (var item in petProvider.locationList) {

      print("helooo");
      print("latlng==${(item.latitude.toString())}");
      markers.add(Marker(
          markerId: const MarkerId('3'),
          position: LatLng(double.parse(item.latitude.toString()),
              double.parse(item.longitude.toString())),
          infoWindow:  InfoWindow(
            title: tr(LocaleKeys.additionText_myPos),
          ),
          icon: BitmapDescriptor.defaultMarker));
    }
    if (petProvider.locationList.isNotEmpty) {
      cameraPosition(ctx);
    } else {
      kGooglePlex = const CameraPosition(
        target: LatLng(26.9124, 75.7873),
        zoom: 14.4746,
      );
    }
    notifyListeners();
  }

  cameraPosition(BuildContext ctx) {
    PetProvider petProvider = Provider.of(ctx, listen: false);
    kGooglePlex = CameraPosition(
      target: LatLng(
          double.parse(petProvider.locationList[0].latitude.toString()),
          double.parse(petProvider.locationList[0].longitude.toString())),
      zoom: 14.4746,
    );
  }
}
