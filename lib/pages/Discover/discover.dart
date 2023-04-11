import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/custom_tab.dart';
import 'package:amaze/components/loading_widget.dart';
import 'package:amaze/components/searchfield.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/models/cart_model.dart';
import 'package:amaze/pages/Discover/components/discover_list.dart';
import 'package:amaze/pages/Discover/discover_detail.dart';
import 'package:amaze/pages/Home/homepage.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  const Discover({super.key, this.searchTerm});
  final String? searchTerm;
  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  bool showSortBy = false;
  String category = '';
  String searchTerm = '';
  late Future<List<BookModel>> _bookList;
  List<BookModel> _sortedData = [];

  @override
  void initState() {
    super.initState();
    getBooks(); // Replace this with your own function that returns a Future<List<String>>
  }

  getBooks() async {
    _bookList = UploadService().getAllBooks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> args =
    //     ModalRoute.of(context)!.settings.arguments as Object;
    // final String query = args['query'];
    List categories = [
      'Literature',
      'Schools/Students',
      'Technology',
      'Home & Garden',
      'Health, Body & Mind',
      'Business',
      'History',
      'Religion'
    ];
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<List<BookModel>>(
              future: _bookList,
              builder: (context, snapshot) {
                _sortedData = (searchTerm == ''
                        ? snapshot.data
                        : snapshot.data!
                            .where((book) =>
                                book.title
                                    .toLowerCase()
                                    .contains(searchTerm.toLowerCase()) ||
                                book.category!
                                    .toLowerCase()
                                    .contains(searchTerm.toLowerCase()))
                            .toList()) ??
                    [];
                _sortedData
                    .sort((a, book) => a.createdAt!.compareTo(book.createdAt!));

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 80),
                        height: size(context).height * 0.225,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(0)),
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
                                  onChanged: (val) {
                                    setState(() {
                                      searchTerm = val;
                                    });
                                  },
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
                            GestureDetector(
                              onTap: () {
                                setState(() => showSortBy = !showSortBy);
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10),
                                // decoration: BoxDecoration(),
                                child: Text(
                                  category != ''
                                      ? category + ' >>'
                                      : 'Sort by Categories >>',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
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
                          DiscoverList(
                            sortedData: _sortedData,
                            snapshot: snapshot,
                          ),
                          // second column for top deals, those ones that are promoted(ads)
                          DiscoverList(
                              snapshot: snapshot,
                              sortedData: _sortedData
                                  .where((book) => book.promoted == true)
                                  .toList()),
                          //third column for new books
                          DiscoverList(
                              snapshot: snapshot, sortedData: _sortedData),
                          //for free books
                          DiscoverList(
                              snapshot: snapshot,
                              sortedData: _sortedData
                                  .where((book) => book.price == '0')
                                  .toList()),
                        ]),
                      ),
                    ],
                  ),
                );
              }),
          !showSortBy //if s false
              ? SizedBox()
              : Align(
                  alignment: Alignment(0, -0.4),
                  child: Container(
                    height: size(context).height * 0.19,
                    color: white,
                    child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: (1 / .19),
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                searchTerm = categories[index];
                                category = categories[index];
                                showSortBy = false;
                              });
                            },
                            child: Container(
                              color: myDarkBlue,
                              child: Center(
                                  child: Text(
                                categories[index],
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          );
                        })),
                  ),
                ),
        ],
      ),
    );
  }
}
