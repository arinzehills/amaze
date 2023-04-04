import 'dart:convert';
import 'dart:io';

import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Books/read_book.dart';
import 'package:amaze/pages/Books/upload_widgets.dart';
import 'package:amaze/pages/Home/creators_navigation.dart';
import 'package:amaze/pages/Profile/about_the_author.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookInfo {
  String title;
  String subtitle;
  String author;
  String isbn;
  String series;
  List contributors;
  File? ebook;
  File? audio;
  File? bookcover;
  BookInfo(
      {required this.title,
      required this.subtitle,
      required this.isbn,
      required this.series,
      required this.author,
      this.bookcover,
      this.ebook,
      this.audio,
      this.contributors = const [
        // {'firstname': '', 'lastname': '', 'type': 'Author'}
      ]});
}

class UploadBookInfo extends StatefulWidget {
  const UploadBookInfo({super.key, required this.bookInfo});
  final BookInfo bookInfo;
  @override
  State<UploadBookInfo> createState() => _UploadBookInfoState();
}

class _UploadBookInfoState extends State<UploadBookInfo> {
  bool loading = false,
      showAbn = false,
      showPricing = false,
      showRange = false,
      ownCopyright = true,
      adult_content = false;
  String about_book = '',
      pricing = '',
      category = '',
      error = '',
      keyword = '',
      age_range = 'Optional';
  String language = 'Book Text Primary Language';
  num wordsLeft = 2000;
  List keywords = [];
  var listLang = [
    'ENGLISH',
    'GERMAN',
    'FRENCH',
    'SPANISH',
    'ITALIAN',
    'JAPANESE',
    'ZULU',
    'SWAHILI',
    'IGBO',
    'HAUSA',
    'YORUBA'
  ];
  var listCategories = [
    'FICTION',
    'NON-FICTION',
    'JUVENILE FICTION',
    'JUVENILE NON-FICTION',
    'COMICS/ILLUSTRATED STORIES',
    'EDUCATION AND REFERENCE',
    'RELIGION',
    'LITERARY COLLECTIONS',
    'NON-CLASSIFIED',
  ];
  final _formKey = GlobalKey<FormState>();

  late BookModel book;
  final cntl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(children: [
            creatorsSettingsPagetitle(context, title: 'Upload'),
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    uploadWidget(
                        // onTap: selectImage,
                        text: 'Language',
                        text2: language,
                        onTap: () {
                          // ),

                          languageList(context,
                              list: listLang,
                              onTap: (val) => {
                                    Navigator.pop(context),
                                    setState(() => language = val)
                                  });
                        }),
                    uploadWidget(
                        // onTap: selectImage,
                        width: size(context).width * 0.98,
                        text: 'Book Description',
                        text2: '${wordsLeft} words remaining'),
                    uploadTextField(
                      withBorder: true,
                      maxLines: 4,
                      onChanged: (val) {
                        setState(() {
                          wordsLeft = wordsLeft - val.length;
                          about_book = val;
                        });
                      },
                    ),
                    uploadWidget(
                        // onTap: selectImage,
                        text: 'Categories',
                        text2: category,
                        onTap: () {
                          // ),
                          languageList(context,
                              list: listCategories,
                              onTap: (val) => {
                                    Navigator.pop(context),
                                    setState(() => category = val)
                                  });
                        }),
                    Divider(
                      color: Color.fromARGB(171, 108, 193, 254),
                    ),
                    uploadTextField(
                        hintText: 'Keywords',
                        cntrl: cntl,
                        willValidate: false,
                        text2: keyword != '' && keyword.length >= 3
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    keywords.add(keyword);
                                  });
                                  cntl.clear();
                                },
                                icon: Icon(Icons.add_circle))
                            : 'Optional',
                        onChanged: (val) {
                          setState(() => {keyword = val});
                        }),
                    Container(
                      width: size(context).width * 0.85,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: keywords
                            .map((keyword) => Text(
                                  keyword.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Divider(
                      color: Color.fromARGB(171, 108, 193, 254),
                    ),
                    copyright(),
                    Padding(
                      padding: EdgeInsets.all(15).copyWith(bottom: 0),
                      child: adultContent(
                          adult_content: adult_content,
                          onTap: (val) {
                            print('val');
                            print(val);
                            print('break');
                            setState(() => {adult_content = val});
                          }),
                    ),
                    uploadWidget(
                        // onTap: selectImage,
                        width: size(context).width * 0.98,
                        text: 'Age Range',
                        text2: age_range,
                        onTap: () => setState((() => showRange = !showRange))),
                    showRange
                        ? addRange(context, onClick: (val) {
                            print('val for age range');
                            print(val);

                            setState(() {
                              age_range = val;
                              showRange = false;
                            });
                          })
                        : SizedBox(),
                    uploadWidget(
                        // onTap: selectImage,
                        width: size(context).width * 0.98,
                        text: 'Price',
                        text2: 'Free',
                        onTap: () =>
                            setState((() => showPricing = !showPricing))),
                    showPricing ? priceWidget(context) : SizedBox(),
                  ]),
                )),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // MyNavigate.navigatejustpush(
                //     ReadBook(
                //       bookFile: widget.bookInfo.ebook,
                //     ),
                //     context);
                VocsyEpub.setConfig(
                  themeColor: Theme.of(context).primaryColor,
                  identifier: "iosBook",
                  scrollDirection: EpubScrollDirection.HORIZONTAL,
                  allowSharing: true,
                  // enableTts: true,
                  nightMode: true,
                );
                VocsyEpub.open(
                  widget.bookInfo.ebook!.path,
                  // first page will open up if the value is null
                );
              },
              child: popUpload(
                  child: SizedBox(
                height: 40,
                child: Center(child: Text('Preview Book')),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  placeHolder: 'Back',
                  // loadingState: loading,
                  pressed: () async {
                    Navigator.pop(context);
                  },
                  height: 40,
                  widthRatio: 0.4,
                  color: Colors.grey[300],

                  textColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                MyButton(
                  placeHolder: 'Upload',
                  height: 40,
                  widthRatio: 0.4,
                  color: myDarkBlue,
                  textColor: Colors.white,
                  loadingState: loading,
                  pressed: () async {
                    // setState(() => loading = true);
                    if (_formKey.currentState!.validate()) {}

                    BookModel book = BookModel(
                        title: '',
                        language: language,
                        about_book: about_book,
                        category: category,
                        keywords: keywords,
                        age_range: age_range,
                        own_copyright: ownCopyright,
                        adult_content: adult_content == true ? 'Yes' : 'No',
                        price: pricing,
                        user_id: user(context)!.id!);
                    var response =
                        await UploadService().uploadBook(book, widget.bookInfo);
                    var body = json.decode(response.body);
                    // print(body);
                    print(body['success']);
                    if (body['success']) {
                      snackBar(
                          CreatorsNavigation(
                            index: 1,
                          ),
                          context,
                          body['message']);
                      setState(() => loading = false);
                    } else {
                      setState(() => loading = false);
                      setState(() => error = body['message']);
                    }
                  },
                )
              ],
            )
          ]))
        ],
      ),
    );
  }

  copyright() => Column(
        children: [
          MyButton(
            placeHolder: 'I own my copy right',
            pressed: () => {
              setState(() => {ownCopyright = !ownCopyright})
            },
            color: myDarkBlue,
            textColor: white,
            child: Checkbox(
              checkColor: Colors.blue,
              activeColor: Colors.white,
              value: ownCopyright,
              onChanged: (val) {},
            ),
          ),
          MyButton(
            placeHolder: 'This is a Public Domain work',
            pressed: () => {
              setState(() => {ownCopyright = !ownCopyright})
            },
            color: Colors.grey[300],
            child: Checkbox(
              value: !ownCopyright,
              onChanged: (val) {},
            ),
          ),
        ],
      );
}
