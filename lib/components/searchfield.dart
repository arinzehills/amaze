import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  SearchField(
      {super.key,
      required this.onChanged,
      this.widthRatio,
      this.withBg = false,
      this.searchHint});
  Function(String)? onChanged;
  String? searchHint;
  var widthRatio;
  bool withBg;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.widthRatio != null
            ? size(context).width * widget.widthRatio
            : size(context).width * 0.85,
        height: 60,
        margin: EdgeInsets.only(left: 6),
        child: TextFormField(
          onChanged: widget.onChanged,
          // keyboardType: TextInputType,

          decoration: InputDecoration(
            hintText: 'Search ${widget.searchHint}',
            hintStyle: TextStyle(color: const Color(0xff626262)),
            filled: true, //<-- SEE HERE
            fillColor: widget.withBg
                ? Color.fromARGB(43, 108, 193, 254)
                : Colors.white,
            suffixIcon: Container(
              color: Color(0xff0BA7F2).withOpacity(0.25),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ));
  }
}
