import 'dart:convert';
import 'dart:io';

import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_text_field.dart';
import 'package:amaze/components/myappbar.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Books/components/add_contributors.dart';
import 'package:amaze/pages/Books/read_book.dart';
import 'package:amaze/pages/Books/upload_book_info.dart';
import 'package:amaze/pages/Books/upload_widgets.dart';
import 'package:amaze/pages/Home/creators_home.dart';
import 'package:amaze/pages/Home/creators_navigation.dart';
import 'package:amaze/pages/Settings/creators_settings.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class UploadBook extends StatefulWidget {
  const UploadBook({super.key});

  @override
  State<UploadBook> createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook> {
  final _formKey = GlobalKey<FormState>();

  BookInfo bookInfo = BookInfo(
      title: '',
      subtitle: '',
      isbn: '',
      series: '',
      author: '',
      audio: null,
      bookcover: null,
      ebook: null);
  bool loading = false,
      showContributors = false,
      showSeries = false,
      showAbn = false;

  var error = '';
  File? book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              creatorsSettingsPagetitle(context, title: 'Upload'),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      uploadTextField(
                          hintText: 'Book Title',
                          text2: "Can't be changed",
                          onChanged: (val) =>
                              setState(() => bookInfo.title = val)),
                      uploadTextField(
                          hintText: 'Subtitle',
                          willValidate: false,
                          text2: "Optional",
                          onChanged: (val) =>
                              setState(() => bookInfo.subtitle = val)),
                      uploadTextField(
                          hintText: 'Primary author',
                          text2: "Can't be changed",
                          onChanged: (val) =>
                              setState(() => bookInfo.author = val)),
                      uploadWidget(
                          text: 'Auto Code or ISBN',
                          text2: 'ABN(default)',
                          onTap: () => setState((() => showAbn = !showAbn))),
                      showAbn ? addAbn() : SizedBox(),
                      uploadWidget(
                          text: 'Add to Series',
                          text2: 'Series1',
                          onTap: () =>
                              setState((() => showSeries = !showSeries))),
                      showSeries ? addToSeries() : SizedBox(),
                      uploadWidget(
                          text: 'Add Contributors',
                          text2: 'Optional',
                          onTap: () => setState(
                              (() => showContributors = !showContributors))),
                      showContributors
                          ? AddContributors(
                              onAdd: (val) {
                                bookInfo.contributors = val;
                                setState((() =>
                                    showContributors = !showContributors));
                                print('bookn infor val');
                                // print(bookInfo);
                                print(val);
                              },
                            )
                          : SizedBox(),
                      Container(
                        width: size(context).width * 0.85,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: bookInfo.contributors!
                              .map((keyword) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${keyword["type"]} ',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      Text(
                                        '${keyword["firstname"]} ${keyword["lastname"]} ',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromARGB(171, 108, 193, 254),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    uploadWidget(
                        text2: bookInfo.ebook != null
                            ? Path.basename(bookInfo.ebook!.path)
                            : '',
                        onTap: selectFile),
                    uploadWidget(
                        text: 'Upload MP3 Audio Version',
                        text2: bookInfo.audio != null
                            ? Path.basename(bookInfo.audio!.path)
                            : 'Optional',
                        onTap: selectAudio),
                    uploadWidget(
                        onTap: selectImage,
                        text: 'Upload eBook Cover (jpg)',
                        text2: bookInfo.bookcover != null
                            ? Path.basename(bookInfo.bookcover!.path)
                            : ''),
                  ],
                ),
              ),
              Divider(
                color: Color.fromARGB(171, 108, 193, 254),
              ),
              Center(
                child: MyButton(
                  placeHolder: 'Next',
                  loadingState: loading,
                  isDisable:
                      bookInfo.ebook != null && bookInfo.bookcover != null
                          ? false
                          : true,
                  pressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print(bookInfo.ebook!.path);

                      MyNavigate.navigatejustpush(
                          UploadBookInfo(bookInfo: bookInfo), context);
                      // MyNavigate.navigatejustpush(
                      //     ReadBook(
                      //       bookFile: book,
                      //     ),
                      //     context);
                    }
                  },
                  height: 40,
                  widthRatio: 0.4,
                  color: myDarkBlue,
                  textColor: Colors.white,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => bookInfo.bookcover = File(path));
  }

  Future selectAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'flac', 'mp4'],
    );
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => bookInfo.audio = File(path));
  }

  Future selectFile() async {
    final docPath = (await getApplicationDocumentsDirectory()).path;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'epub', 'txt'],
      allowMultiple: false,
    );
    if (result == null) return;
    File file = File(result.files.single.path!);
    // String path=
    if (Platform.isIOS) {
      file = await file.copy('$docPath/${Path.basename(file.path)}');
    }
    setState(() => bookInfo.ebook = file);
  }
}
