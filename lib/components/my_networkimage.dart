import 'package:amaze/constants/constants.dart';
import 'package:amaze/fullresourcepage/full_photo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

class MyNetworkImage extends StatefulWidget {
  final double? height;
  final double? width;
  final String? imgUrl;
  final bool isCircular;
  const MyNetworkImage(
      {Key? key, this.height, this.width, this.imgUrl, this.isCircular = true})
      : super(key: key);

  @override
  State<MyNetworkImage> createState() => _MyNetworkImageState();
}

class _MyNetworkImageState extends State<MyNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: CupertinoButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullPhotoPage(
                url: widget.imgUrl ?? 'profilePhoto',
              ),
            ),
          );
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.isCircular ? 45 : 0),
            child: Image.network(
              widget.imgUrl ?? '',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, object, stackTrace) {
                return SvgPicture.asset(
                  'assets/svg/usericon.svg',
                  height: 73,
                );
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.white,
                  width: 90,
                  height: 90,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: myDarkBlue,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
