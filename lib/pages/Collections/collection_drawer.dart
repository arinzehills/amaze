import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';

class CollectionDrawer extends StatefulWidget {
  CollectionDrawer({required this.sliderWidth, required this.isOpen});
  double sliderWidth;
  bool isOpen;
  @override
  _CollectionDrawerState createState() => _CollectionDrawerState();
}

class _CollectionDrawerState extends State<CollectionDrawer> {
  var _categoriesList = [
    'Recently Download',
    'Schools/Students',
    'Comics',
    'Business/Investing',
    'Body/Mind',
    'Religion'
  ];
  @override
  Widget build(BuildContext context) {
    return
        // Slider
        AnimatedContainer(
      width: widget.sliderWidth,
      height: size(context).height * 0.7,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 224, 222, 222),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Visibility(
        visible: widget.isOpen,
        child: ListView(
          padding: EdgeInsets.zero,
          children: _categoriesList.asMap().entries.map((entry) {
            int index = entry.key;
            String item = entry.value;
            return Container(
              padding: const EdgeInsets.all(8.0),
              // height: 60,
              child: Column(
                children: [
                  index == 0
                      ? Divider(
                          thickness: 2,
                        )
                      : SizedBox(),
                  Text(item),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
