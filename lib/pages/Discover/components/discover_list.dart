import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/loading_widget.dart';
import 'package:amaze/components/noitems_widget.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Discover/discover_detail.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class DiscoverList extends StatelessWidget {
  final List<BookModel> sortedData;
  final snapshot;
  const DiscoverList({
    super.key,
    required this.sortedData,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return snapshot.data == null
        ? LoadingWidget()
        : sortedData.length == 0
            ? NoItemsWidget(
                text: 'No books for this category',
              )
            : ListView.builder(
                itemCount: sortedData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  BookModel book = sortedData[index];

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
                            create: (context) => DiscoverProvider(),
                            child: DiscoverDetail(book: book),
                          ),
                        ),
                      )
                    },
                  );
                },
              );
  }
}
