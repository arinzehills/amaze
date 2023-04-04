import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/custom_tab.dart';
import 'package:amaze/components/loading_widget.dart';
import 'package:amaze/components/searchfield.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/models/cart_model.dart';
import 'package:amaze/pages/Discover/discover_detail.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<BookModel>>(
          future: UploadService().getAllBooks(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    height: size(context).height * 0.225,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(0)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [myBlue, myPurple])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SearchField(
                              onChanged: (val) {},
                              searchHint: 'Store',
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 10),
                          // decoration: BoxDecoration(),
                          child: Text(
                            'Sort by Categories>>',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size(context).height * 0.96,
                    child: CustomTab(items: [
                      'Top Selling',
                      'Deals',
                      'New',
                      'Free'
                    ], widgetsItems: [
                      snapshot.data == null
                          ? LoadingWidget()
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 16),
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                BookModel book = snapshot.data![index];

                                // CartModel cartModel =
                                //     CartModel.fromJson(book.toJson());

                                return CustomListTile(
                                  book: book,
                                  onClick: () => {
                                    // MyNavigate.navigatejustpush(
                                    // DiscoverDetail(book: book), context)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChangeNotifierProvider(
                                          create: (context) =>
                                              DiscoverProvider(),
                                          child: DiscoverDetail(book: book),
                                        ),
                                      ),
                                    )
                                  },
                                );
                              },
                            ),
                      // secong column
                      // ListView.builder(
                      //   itemCount: 3,
                      //   shrinkWrap: true,
                      //   padding: EdgeInsets.only(top: 16),
                      //   physics: ScrollPhysics(),
                      //   itemBuilder: (context, index) {
                      //     // User user = snapshot.data![index];
                      //     return CustomListTile(
                      //       onClick: () => {
                      //         MyNavigate.navigatejustpush(
                      //             DiscoverDetail(), context)
                      //       },
                      //     );
                      //   },
                      // ),
                      Center(
                        child: Text('New books'),
                      ),
                      Center(
                        child: Text('New Free books'),
                      )
                    ]),
                  ),
                ],
              ),
            );
          }),
    );
    ;
  }
}
