import 'dart:io';

import 'package:amaze/components/download_alert.dart';
import 'package:amaze/components/utilities_widgets/consts.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';

import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Orders/order_succcess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DiscoverProvider extends ChangeNotifier {
  bool downloaded = false;
  final _downloadBox = Hive.box('downloads');
// @override
//   void onInit() async {
// checkDownload(book)
//     super.onInit();
//   }
  Future downloadFile(BuildContext context, BookModel book) async {
    PermissionStatus permission = await Permission.storage.status;

    if (permission != PermissionStatus.granted) {
      await Permission.storage.request();
      // access media location needed for android 10/Q
      await Permission.accessMediaLocation.request();
      // manage external storage needed for android 11/R
      await Permission.manageExternalStorage.request();
      startDownload(context, book);
    } else {
      startDownload(context, book);
    }
  }

  startDownload(BuildContext context, BookModel book) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir!.path.split('Android')[0] + '${Constants.appName}')
          .createSync();
    }

    String path = Platform.isIOS
        ? appDocDir!.path + '/${book.filename}'
        : appDocDir!.path.split('Android')[0] +
            '${Constants.appName}/${book.filename}';
    File file = File(path);

    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }
    book.filePath = path;
    book.createdAt = DateTime.now().toString();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: book.bookURL!,
        path: path,
      ),
    ).then((v) {
      // When the download finishes, we then add the book
      // to our local database
      if (v != null) {
        addDownload(book, context);
      }
    });
  }

  addDownload(BookModel book, context) async {
    final downloadBox = await Hive.openBox('downloads');
    final downloadItem = downloadBox.get(book.id);
    if (downloadItem != null) {
      // downloadBox.delete(book.id);
      MyNavigate.navigatejustpush(OrderSuccess(), context);

      return;
    }
    await downloadBox.put(book.id, book.toJson());
    checkDownload(book, true);
    MyNavigate.navigatejustpush(OrderSuccess(), context);
  }

  deleteDownload(BookModel book) async {
    // print(book.filePath);

    final file = File(book.filePath!);
    bool fileExist = await file.exists();
    print(fileExist);
    final downloadBox = await Hive.openBox('downloads');
    downloadBox.delete(book.id);
  }

  // check if book has been downloaded before
  checkDownload(BookModel book, bool isNew) async {
    if (isNew) {
      String path = book.filePath!;
      if (await File(path).exists()) {
        setDownloaded(true);
      } else {
        setDownloaded(false);
      }
    } else {
      print('old run');

      if (_downloadBox.containsKey(book.id)) {
        print('old run with true');
        setDownloaded(true);
        print(downloaded);
      } else {
        print('old run with false');
        setDownloaded(false);
      }
    }
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }
}
