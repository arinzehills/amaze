import 'package:amaze/components/my_networkimage.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/models/cart_model.dart';
import 'package:amaze/pages/Discover/reviewscontainer.dart';
import 'package:amaze/pages/Profile/about_the_author.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatelessWidget {
  final BookModel? book;
  final bool showRightIcon;
  final bool isDeleteRightIcon;
  final VoidCallback? onClick;

  CustomListTile({
    this.book,
    this.showRightIcon = true,
    this.isDeleteRightIcon = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: MyNetworkImage(
                      isCircular: false,
                      imgUrl:
                          book!.bookCoverImageURL ?? 'assets/images/book.jpg',
                      height: 110,
                      width: 74,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: BookDescWidget(
                      book: book!,
                      showRightIcon: showRightIcon,
                      isDeleteRightIcon: isDeleteRightIcon,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class BookDescWidget extends StatelessWidget {
  const BookDescWidget({
    required this.book,
    this.showRightIcon = true,
    this.isDeleteRightIcon = false,
    this.showPrice = true,
  });

  final BookModel book;
  final bool showRightIcon;
  final bool showPrice;
  final bool isDeleteRightIcon;

  @override
  Widget build(BuildContext context) {
    // BookModel book = postsController!.allPost[courseIndex!];

    final cartController = Get.put(CartService());
    if (cartController.isInCart(book)) {
      print(book.filename);
      print(book.filename);
    }
    ;
    return Consumer<DiscoverProvider>(
        builder: (context, DiscoverProvider provider, child) {
      return Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                book.title ?? book.filename ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'paperback-1',
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0)),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < calcTotalReview(book.reviews!)
                                ? Icons.star
                                : Icons.star_border,
                            size: 16.0,
                            color: Color(0xffFFC107),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          MyNavigate.navigatejustpush(
                              AboutTheAuthor(
                                user_id: book.user_id,
                              ),
                              context)
                        },
                        child: Text(
                          'By ${book.user_name} (Author)',
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  // the price
                  !showRightIcon
                      ? SizedBox()
                      : isDeleteRightIcon
                          ? GestureDetector(
                              onTap: () {
                                provider.deleteDownload(book);
                                // setState(()=>)
                              },
                              child: Container(
                                height: 70,
                                child: Icon(Icons.delete),
                              ),
                            )
                          : Container(
                              height: 70,
                              // width: 100,
                              margin:
                                  EdgeInsets.only(left: !showPrice ? 15 : 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Obx(
                                    () => GestureDetector(
                                      onTap: (() =>
                                          cartController.isInCart(book)
                                              ? cartController.removeBook(book)
                                              : cartController.addBook(book)),
                                      child: SvgPicture.asset(
                                        'assets/svg/loveicon.svg',
                                        color: cartController.isInCart(book)
                                            ? myDarkBlue
                                            : null,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  showPrice
                                      ? Text('${book.price}NGN')
                                      : SizedBox()
                                ],
                              ),
                            ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
