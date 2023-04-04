import 'package:amaze/components/loading_widget.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_networkimage.dart';
import 'package:amaze/components/noitems_widget.dart';
import 'package:amaze/components/searchfield.dart';
import 'package:amaze/components/skeleton.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Home/creators_home.dart';
import 'package:amaze/pages/Profile/about_the_author.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class Bookshelf extends StatefulWidget {
  const Bookshelf({super.key});

  @override
  State<Bookshelf> createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppbar(),
      body: FutureBuilder<List<BookModel>>(
          future: UploadService().getUserBooks(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return LoadingWidget();
            }

            return SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      welcomeText(context, textColor: myDarkBlue),
                      SearchField(
                        onChanged: (val) {},
                        searchHint: 'Title',
                        widthRatio: 0.56,
                        withBg: true,
                      ),
                    ],
                  ),
                ),
                snapshot.data!.length == 0
                    ? NoItemsWidget(
                        text: 'You have not added any books yet',
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var book = snapshot.data![index];
                          return shelfWidget(book);
                        })
              ],
            ));
          }),
    );
  }

  Widget bookCardWidget(BookModel book) {
    return Expanded(
      child: ListTile(
        // leading: MyNetworkImage(),
        horizontalTitleGap: 3,
        leading: Image.network(
          book.bookCoverImageURL ?? 'assets/svg/booksample.svg',
          height: 55,
          width: 30,
        ),
        title: Text(
          BookModel.formatFileName(filename: book.filename) ?? 'Come Up',
          style: biggerTextStyle(true),
        ),
        subtitle: Text(
          'By Aima ,',
          style: biggerTextStyle(false),
        ),
      ),
    );
  }

  TextStyle biggerTextStyle(bool isBigger) =>
      TextStyle(fontSize: isBigger ? 13 : 10);

  Widget shelfWidget(BookModel book) {
    return Container(
      height: 85,
      decoration:
          BoxDecoration(border: Border.all(color: transparentBlue, width: 3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Color.fromARGB(43, 108, 193, 254),
            height: 100,
            width: 8,
            constraints: BoxConstraints(
              maxWidth: 8,
            ),
          ),
          bookCardWidget(book),
          Container(
            width: 4,
            height: 100,
            color: Color.fromARGB(43, 108, 193, 254),
            constraints: BoxConstraints(
              maxWidth: 15,
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                'LIVE ${book.createdAt}',
                style: biggerTextStyle(true)
                    .copyWith(color: Color.fromARGB(255, 57, 239, 63)),
              ),
              subtitle: Text('Submitted ${book.createdAt}',
                  style: biggerTextStyle(false)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              placeHolder: 'Edit',
              pressed: () {},
              color: myDarkBlue,
              textColor: white,
              widthRatio: 0.21,
              height: 45,
            ),
          )
        ],
      ),
    );
  }
}
