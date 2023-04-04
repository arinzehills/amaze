import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/loading_widget.dart';
import 'package:amaze/components/noitems_widget.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/database/download_helper.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Books/read_book.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/download_service.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  var db = DownloadsDB();
  List dls = [];
  static final uuid = Uuid();

  getDownloads() async {
    List l = await db.listAll();
    setState(() {
      dls.addAll(l);
    });
  }

  @override
  void initState() {
    super.initState();
    getDownloads();
  }

  @override
  Widget build(BuildContext context) {
    print('dls');
    print(dls);
    return Consumer<DiscoverProvider>(
        builder: (context, DiscoverProvider provider, child) {
      return Container(

          // return snapshot.data == null
          //     ? LoadingWidget()
          //     :

          child: dls.length == 0
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
              : _buildDownloads());
    });
  }

  _buildDownloads() {
    return ListView.builder(
      itemCount: dls.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        Map<String, dynamic> dl = dls[index];
        BookModel book = BookModel.fromJson(dl);
        print(book.user_id);
        print(book.user_id);
        print(book.user_id);
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
