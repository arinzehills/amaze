import 'package:amaze/components/skeleton.dart';
import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 130,
            child: Row(
              children: [
                Skeleton(
                  width: 105,
                  height: 130,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      width: size(context).width * 0.7,
                    ),
                    Skeleton(
                      width: size(context).width * 0.4,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
