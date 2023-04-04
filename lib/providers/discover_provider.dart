import 'dart:io';

import 'package:amaze/components/download_alert.dart';
import 'package:amaze/components/utilities_widgets/consts.dart';
import 'package:amaze/database/download_helper.dart';
import 'package:amaze/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DiscoverProvider extends ChangeNotifier {
  var dlDB = DownloadsDB();

  bool downloaded = false;

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
        addDownload(book);
      }
    });
  }

  addDownload(BookModel book) async {
    await dlDB.removeAllWithId();
    await dlDB.add(book.toJson());
    checkDownload(book);
  }

  deleteDownload(BookModel book) async {
    await dlDB.remove(book.toJson());
  }

  deleteAllDownloads() async {
    await dlDB.removeAllDownloads();
  }

  // check if book has been downloaded before
  checkDownload(BookModel book) async {
    List downloads = await dlDB.check({'id': book.id});

    if (downloads.isNotEmpty) {
      // check if book has been deleted
      String path = downloads[0]['filePath'];

      if (await File(path).exists()) {
        setDownloaded(true);
      } else {
        setDownloaded(false);
      }
    } else {
      setDownloaded(false);
    }
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }
}
