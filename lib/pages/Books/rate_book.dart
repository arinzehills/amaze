import 'package:amaze/components/my_button.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Profile/about_the_author.dart';
import 'package:amaze/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RateBook extends StatefulWidget {
  RateBook({super.key, required this.book});
  BookModel book;
  @override
  State<RateBook> createState() => _RateBookState();
}

class _RateBookState extends State<RateBook> {
  String comment = '';
  int rate = 0;

  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppbar(
        title: 'Rate This Book',
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.book.title ?? widget.book.filename ?? '',
              style: TextStyle(fontSize: 32),
            ),
            Card(
              // decoration: decora,
              child: Column(
                children: [
                  Text('Select your rate'),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => GestureDetector(
                          onTap: (() => setState(() => {rate = index + 1})),
                          child: Icon(
                            rate >= index + 1 ? Icons.star : Icons.star_border,
                            size: 20.0,
                            color: Color(0xffFFC107),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter a caption' : null,
              keyboardType: TextInputType.multiline,
              // initialValue: widget.decription,
              maxLines: 20,
              decoration: InputDecoration(
                filled: true, //<-- SEE HERE
                fillColor: Color.fromARGB(43, 108, 193, 254),
                hintText: 'What can u say about this...',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (val) {
                setState(() => comment = val);
              },
            ),
            Text(error),
            Padding(
              padding: const EdgeInsets.all(5).copyWith(),
              child: MyButton(
                placeHolder: 'Submit Review',
                widthRatio: 0.45,
                height: 45,
                textColor: white,
                isOval: true,
                pressed: () async {
                  // MyNavigate.navigatejustpush(Checkout(), context);
                  var response = await UploadService()
                      .reviewBook(rate, comment, widget.book.id);
                  // print(response['success']);
                  if (response['success'] == true) {
                    setState(() => {});
                    print('success rated');
                    setState(() => error = response['message']);
                  } else {
                    setState(() => loading = false);
                    setState(() => error = response['message']);
                  }
                },
                isGradientButton: true,
                gradientColors: myGradient,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
