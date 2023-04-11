import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/loading_widget.dart';
import 'package:amaze/components/noitems_widget.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Books/read_book.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/download_service.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  // var db = DownloadsDB();
  late ValueNotifier<Object?> _downloads;
  List dls = [];
  static final uuid = Uuid();

  getDownloads() async {
    // List l = await db.listAll();
    _downloads = Hive.box('downloads').listenable() as ValueNotifier<Object?>;
    setState(() {
      // dls.addAll(l);
    });
  }

  @override
  void initState() {
    super.initState();
    // getDownloads();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('downloads').listenable(),
        builder: (context, box, child) {
          //  final filteredList = query.isEmpty
          // ? myList
          // : myList.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();

          return Container(

              // return snapshot.data == null
              //     ? LoadingWidget()
              //     :

              child: box.length == 0
                  ? NoItemsWidget(
                      text: 'No downloads yet',
                      clicked: () {
                        MyNavigate.navigatejustpush(
                            HomepageNavigation(
                              index: 2,
                            ),
                            context);
                      },
                    )
                  : _buildDownloads(box));
        });
  }

  _buildDownloads(box) {
    return ListView.builder(
      itemCount: box.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        // Map<String, dynamic> dl = dls[index];
        // BookModel book = BookModel.fromJson(dl);
        final bookJson = box.getAt(index);

        Map<String, dynamic> myNewMap = Map<String, dynamic>.from(bookJson);
        BookModel book = BookModel.fromJson(myNewMap);

        return Dismissible(
          key: ObjectKey(uuid.v4()),
          direction: DismissDirection.endToStart,
          // background: _dismissibleBackground(),
          // onDismissed: (d) => _deleteBook(dl, index),
          child: CustomListTile(
            book: book,
            showRightIcon: true,
            isDeleteRightIcon: true,
            onClick: () => {
              // MyNavigate.navigatejustpush(
              //     ReadBook(bookFile: book.filePath!), context)
              VocsyEpub.setConfig(
                themeColor: Theme.of(context).primaryColor,
                identifier: "iosBook",
                scrollDirection: EpubScrollDirection.HORIZONTAL,
                allowSharing: true,
                enableTts: true,
                nightMode: true,
              ),
              VocsyEpub.open(
                book.filePath!,
                // first page will open up if the value is null
              )
            },
          ),
        );
      },
    );
  }
}
