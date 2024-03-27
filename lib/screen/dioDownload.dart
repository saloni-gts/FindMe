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
  bool isLoading = false;
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    PetProvider petProvider = Provider.of(context, listen: false);

    String fileType = "";
    if (widget.uri.contains('jpg') || widget.uri.contains('png')) {
      fileType = "jpg";
    } else if (widget.uri.contains('pdf')) {
      fileType = "pdf";
    }

    String url = widget.uri;
    var name = widget.uri.split("/").last;
    String filename = name;

    final path = await _getFilePath(filename);
    print("pTH----$path");

    if (widget.uri.contains('jpg') || widget.uri.contains('png')) {
      setState(() {
        isLoading = true;
      });
    } else if (widget.uri.contains('pdf')) {
      print("run code");

      Directory download = Directory('/storage/emulated/0/Download');
      print("pTH----$path");
      if (Platform.isAndroid) {
        download = await getApplicationDocumentsDirectory();

        print("downloaddownload android=> ${download.path}");
      } else if (Platform.isIOS) {
        download = await getApplicationDocumentsDirectory();
        print("downloaddownload ios=> $download");
      }

      print("downloaddownload $download");

      final file = File("${download.path}/$filename");

      if (file.existsSync()) {
        print("------ ALREADY EXISTS -----");
      } else {
        print("------FILE DOES NOT EXIST DOWNLOADING ----");
        try {
          setState(() {
            isLoading = true;
          });
          final response = await Dio().get(url, onReceiveProgress: ((count, total) {
            petProvider.setLoadVal("${(count / total * 100).toStringAsFixed(0)}%");
            print("${(count / total * 100).toStringAsFixed(0)}%");
          }),
              options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
              )).onError((error, stackTrace) {
            print("error>>>   $error");
            print("stackTrace>>>   $stackTrace");
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
            context: context,
            type: CoolAlertType.success,
            text: tr(LocaleKeys.additionText_downloadSuccess),
            onConfirmBtnTap: () {
              try {
                print("ref.path>>>>>>># ${ref.path}");
                fileOpened(ref.path);
              } catch (error, stackTrace) {
                print("stack and error<>>>>>  $stackTrace  $error");
              }

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
    PetProvider petProvider = Provider.of(context, listen: false);
    petProvider.displayLoad = "0%";
    print("url widget.uri ${widget.uri}");
    super.initState();
    startDownloading();
  }

  String downloadprogress = "0";
  @override
  Widget build(BuildContext context) {
    setState(() {
      downloadprogress = (progress * 100).toInt().toString();
    });

    return Consumer<PetProvider>(builder: (context, petProvider, child) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              tr(LocaleKeys.additionText_downloading),
              style: const TextStyle(fontSize: 20),
            ),
            Text(widget.uri.split('/').last),
            Text(petProvider.displayLoad),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
          ],
        ),
      );
    });
  }

  void fileOpened(String path) {
    try {
      OpenFile.open(path);
      Navigator.pop(GlobalVariable.navState.currentContext!);
    } catch (error, stackTrace) {
      print("error>>>   $error");
      print("stackTrace>>>> $stackTrace");
    }
  }
}
