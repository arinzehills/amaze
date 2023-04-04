import 'dart:io';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';

import 'package:vocsy_epub_viewer/epub_viewer.dart';

class ReadBook extends StatefulWidget {
  const ReadBook({super.key, this.location, this.bookFile});
  final String? location;
  final bookFile;

  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  late final EpubController _epubController;

  @override
  void initState() {
    super.initState();
    _epubController = EpubController(
      // document: EpubDocument.openData(
      //   widget.bookFile,
      // ),
      document: EpubDocument.openAsset('assets/files/rich.epub'),
      epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
    );
    // VocsyEpub.setConfig(
    //   themeColor: Theme.of(context).primaryColor,
    //   identifier: "iosBook",
    //   scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    //   allowSharing: true,
    //   enableTts: true,
    //   nightMode: true,
    // );
    // if (this.mounted) {
    //   VocsyEpub.open(
    //     widget.bookFile,
    //     // first page will open up if the value is null
    //   );
  }

  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookFile.path),
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController,
        ),
      ),
      body: EpubView(
        controller: _epubController,
      ),
    );
  }
}
