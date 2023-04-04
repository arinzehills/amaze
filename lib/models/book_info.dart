import 'dart:convert';

import 'package:amaze/components/utilities_widgets/mydate_formatter.dart';
import 'package:amaze/models/review_model.dart';

BookModel BookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String BookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  BookModel({
    this.id,
    this.usersId,
    this.primary_author,
    this.isbn,
    this.series,
    required this.contributors,
    this.bookCover,
    this.ebook,
    this.filename,
    this.filePath,
    this.reviews,
    this.createdAt,
  });

  String? id;
  String? usersId;
  String? primary_author;
  String? isbn;
  String? series;
  String contributors;
  String? bookCover;
  String? ebook;
  String? filePath;
  String? filename;
  List<Map>? reviews;
  String? createdAt;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["_id"],
        usersId: json["user_id"],
        primary_author: json["primary_author"],
        isbn: json["isbn"],
        series: json["series"],
        contributors: json["contributors"],
        bookCover: json["bookCover"],
        ebook: json["ebook"],
        filePath: json['filePath'] ?? "",
        filename: json["filename"], //wether file or image
        reviews: json["reviews"], //wether file or image
        createdAt: MyDateFormatter.dateFormatter(
          datetime:
              DateTime.parse(json["createdAt"] ?? '2022-11-02 19:10:31.998691'),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usersId": usersId,
        "isbn": isbn,
        "series": series,
        "contributors": contributors,
        "bookCover": bookCover,
        "ebook": ebook,
        "filename": filename,
        "filePath": filePath,
        "reviews": reviews,
        // "createdAt": createdAt,
      };
  static String? formatFileName({filename}) {
    return filename.substring(0, filename.indexOf('.'));
  }
}
