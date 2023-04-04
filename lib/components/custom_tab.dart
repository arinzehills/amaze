import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTab extends StatefulWidget {
  CustomTab({Key? key, required this.items, required this.widgetsItems})
      : super(key: key);
  List<String> items = const ['a', 'b'];
  List<Widget> widgetsItems;
  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 0),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => {currentIndex = index});
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 40,
                          width: 83,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: currentIndex == index
                                      ? myGradient
                                      : [
                                          Color.fromARGB(35, 34, 86, 255),
                                          Color.fromARGB(65, 20, 118, 255)
                                        ],
                                  begin: Alignment.topCenter)),
                          margin: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              widget.items[index],
                              style: GoogleFonts.laila(
                                  color: currentIndex == index
                                      ? Colors.white
                                      : myDarkBlue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          //Main Body
          Container(
              width: double.infinity,
              height: size(context).height * 0.67,
              margin: EdgeInsets.only(top: 10),
              child: widget.widgetsItems[currentIndex]),
        ],
      ),
    );
  }
}
