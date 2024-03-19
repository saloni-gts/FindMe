import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/api/network_calls.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


import 'package:http/http.dart' as http;


import '../components/globalnavigatorkey.dart';
import '../generated/locale_keys.g.dart';
import '../provider/petprovider.dart';



class DownloadingDailog extends StatefulWidget {
  String uri;

  DownloadingDailog({
    required this.uri,
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadingDailog> createState() => _DownloadingDailogState();
}

class _DownloadingDailogState extends State<DownloadingDailog> {
  // PetProvider petProvider=Provider.of(context,listen: false);
  bool isLoading = false;
  Dio dio = Dio();
  double progress = 0.0;



  void startDownloading() async {
    PetProvider petProvider=Provider.of(context,listen: false);

    String fileType = "";
    if (widget.uri.contains('jpg') || widget.uri.contains('png')) {
      fileType = "jpg";
    } else if (widget.uri.contains('pdf')) {
      fileType = "pdf";
    }

    String url = widget.uri;
    var name = widget.uri.split("/").last;
    String filename = "$name";

    final path = await _getFilePath(filename);

    if (widget.uri.contains('jpg') || widget.uri.contains('png')) {
      setState(() {
        isLoading = true;
      });

    } else if (widget.uri.contains('pdf')) {
      print("run code");
      // try {
      //   var data = await http.get(Uri.parse(url));
      //   var bytes = data.bodyBytes;
      //   var dir = await getApplicationDocumentsDirectory();
      //   File file = File("${dir.path}/" + filename + ".pdf");
      //   print(" directory path of pdf is ${dir.path}");
      //   File urlFile = await file.writeAsBytes(bytes).whenComplete(() {
      //
      //     print("success fully pdf downloaded ");
      //   });
      //   print("url is >>>>>>>>> ${urlFile.path}");
      //   // return urlFile;
      // } catch (e) {
      //   throw Exception("Error opening url file");
      // }


      // Directory download = Directory('/storage/emulated/0/Download');
      Directory download=Directory('/storage/emulated/0/Download');


      if(Platform.isAndroid){
         // download = Directory('/storage/emulated/0/Downloads');
         download=await getApplicationDocumentsDirectory();

         print("downloaddownload android=> ${download}");
      }

      else if(Platform.isIOS){
        download=await getApplicationDocumentsDirectory();
        print("downloaddownload ios=> ${download}");
      }

      print("downloaddownload ${download}");

      final file = File("${download.path}/$filename");

      if (file.existsSync()) {
        print("------ ALREADY EXISTS -----");
      } else {
        print("------FILE DOES NOT EXIST DOWNLOADING ----");
        try {
          setState(() {
            isLoading = true;
          });
          final response = await Dio()
              .get(url,
              onReceiveProgress: ((count, total){
                petProvider.setLoadVal((count / total * 100).toStringAsFixed(0) + "%");
                print((count / total * 100).toStringAsFixed(0) + "%");
              }),

              options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                // receiveTimeout: 0,
              ))
              .onError((error, stackTrace) {
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
            return showToast("");
          });
          print("file.existsSync()===>${file.existsSync()}");
          final ref = file.openSync(mode: FileMode.write);
          ref.writeFromSync(response.data);
          print("ref ref ${ref.path}");

          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
          CoolAlert.show(
              context: context, type: CoolAlertType.success, text: tr(LocaleKeys.additionText_downloadSuccess),
              onConfirmBtnTap: (){
                fileOpened(ref.path);

                // OpenFile.open(ref.path);
                // Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PetDashboard()));
              },

              );



          await ref.close();

          // return filename;
        } catch (e) {
          print("------ IN CATCH ----");
          print(e.toString());
          Navigator.pop(context);
          return null;
        }
      }
    }
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    PetProvider petProvider=Provider.of(context,listen: false);
    petProvider.displayLoad="0%";
    print("url widget.uri ${widget.uri}");
    super.initState();
    startDownloading();
  }

  // save() async {
  //   var response = await Dio().get(
  //       "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
  //       options: Options(responseType: ResponseType.bytes));
  //   final result = await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(response.data),
  //       quality: 60,
  //       name: "hello");
  //   print(result);
  // }
  String downloadprogress="0";
  @override
  Widget build(BuildContext context) {
    setState((){
       downloadprogress = (progress * 100).toInt().toString();
    });


    return Consumer<PetProvider>(
      builder: (context,petProvider,child) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
             tr(LocaleKeys.additionText_downloading),
                style: TextStyle(fontSize: 20),
              ),
              Text(widget.uri.split('/').last),
              Text(petProvider.displayLoad),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: const CircularProgressIndicator(
                    color: Colors.black,

                  )),
            ],
          ),
        );
      }
    );
  }



  void fileOpened(String path) {

    OpenFile.open(path);
    Navigator.pop(GlobalVariable.navState.currentContext!,);


  }
}