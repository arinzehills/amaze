import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/icon_container.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_networkimage.dart';
import 'package:amaze/components/searchfield.dart';
import 'package:amaze/components/skeleton.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/models/review_model.dart';
import 'package:amaze/pages/Books/rate_book.dart';
import 'package:amaze/pages/Discover/reviewscontainer.dart';
import 'package:amaze/pages/Orders/order_succcess.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/download_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DiscoverDetail extends StatefulWidget {
  DiscoverDetail({super.key, required this.book});
  BookModel book;
  @override
  State<DiscoverDetail> createState() => _DiscoverDetailState();
}

class _DiscoverDetailState extends State<DiscoverDetail> {
  @override
  Widget build(BuildContext context) {
    var reviews = widget.book.reviews;
    return Consumer<DiscoverProvider>(
        builder: (context, DiscoverProvider provider, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, right: 10),
                height: size(context).height * 0.21,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(0)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [myBlue, myPurple])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
              ),
              Container(
                // color: Colors.red,
                // padding: EdgeInsets.only(right: 10),

                margin: EdgeInsets.only(top: 140),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(-0.1, -1),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                MyNetworkImage(
                                  isCircular: false,
                                  imgUrl: widget.book.bookCoverImageURL ??
                                      'assets/images/book.jpg',
                                  height: 150,
                                  width: 94,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        calcTotalReview(widget.book.reviews!)
                                            .toStringAsFixed(1),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 16.0,
                                        color: Color(0xffFFC107),
                                      ),
                                      Text(
                                        ' ${widget.book.reviews!.length} reviews',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // For rating
                            Column(
                              children: [
                                TextButton(
                                  onPressed: (() => MyNavigate.navigatejustpush(
                                      RateBook(
                                        book: widget.book,
                                      ),
                                      context)),
                                  child: Text(
                                    'Rate this eBook',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                BookDescWidget(
                                  book: widget.book,
                                  showRightIcon: true,
                                  showPrice: false,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize:
                                                      14), //apply style to all
                                              children: [
                                            TextSpan(
                                                text: '200 ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600])),
                                            TextSpan(
                                                text: 'pages ',
                                                style: TextStyle()),
                                          ])),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('Share'))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                    Container(
                      width: size(context).width * 0.88,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyButton(
                                  placeHolder: 'Free Sample',
                                  widthRatio: 0.4,
                                  height: 45,
                                  withBorder: true,
                                  textColor: Colors.black,
                                  pressed: () {}),
                              _buildDownloadReadButton(
                                  provider, context, widget.book)
                            ],
                          ),
                          // The remaining book details
                          SizedBox(
                            height: 20,
                          ),
                          buildBoldText('About this eBook'),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.book.about_book ??
                                'About this eBook is the English for ',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 15),
                          ),
                          buildBoldText('Reviews and Ratings'),
                          ReviewsContainer(reviews: reviews!),
                          Row(
                            children: [
                              buildBoldText('More by Author'),
                              SizedBox(
                                width: 20,
                              ),
                              IconContainer(
                                icon: Icons.arrow_forward,
                                color: myBlue,
                              )
                            ],
                          ),
                          buildBoldText('Similar Books'),
                          Container(
                            height: 170,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Skeleton(
                                    width: 95,
                                    // height: 130,
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _buildDownloadReadButton(
      DiscoverProvider provider, BuildContext context, BookModel book) {
    return MyButton(
        placeHolder:
            provider.downloaded ? 'Read book' : 'Buy #' + widget.book.price,
        height: 45,
        textColor: Colors.white,
        widthRatio: 0.4,
        color: myDarkBlue,
        pressed: () async {
          // setState(() => loading = true);
          provider.downloaded
              ? openBook(provider)
              // : provider.downloadFile(context, book);
              : provider.deleteDownload(book);
        });
  }

  openBook(DiscoverProvider provider) async {}
  Widget buildBoldText(text) => Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Text(
          text ?? 'data',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              fontSize: 16),
        ),
      );
}
