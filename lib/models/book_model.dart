import 'dart:convert' as dartjson;

import 'dart:convert';

import 'package:amaze/components/utilities_widgets/mydate_formatter.dart';
import 'package:amaze/models/review_model.dart';

// BookModel BookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

// String BookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  BookModel({
    this.id,
    required this.user_id,
    this.user_name,
    required this.title,
    this.subtitle,
    this.promoted,
    this.language,
    this.about_book,
    this.isbn,
    this.series,
    this.category,
    required this.price,
    this.bookCoverImageURL,
    this.bookURL,
    this.audioURL,
    this.contributors = const [],
    this.filename,
    this.adult_content,
    this.age_range,
    this.own_copyright,
    this.filePath,
    this.keywords = const [],
    this.reviews,
    this.createdAt,
  });

  String? id;
  String user_id;
  String? user_name;
  String? author;
  String title;
  String? subtitle;
  bool? promoted;
  String? language;
  String? about_book;
  String? isbn;
  String? series;
  String? category;
  String price;
  String? bookCoverImageURL;
  String? bookURL;
  String? audioURL;
  String? filename;
  String? adult_content;
  String? age_range;
  bool? own_copyright;
  String? filePath;
  List? reviews;
  List? keywords;
  List? contributors;
  String? createdAt;

  factory BookModel.fromJson(Map<String, dynamic> json, {stringJson}) {
    return BookModel(
      id: json["_id"] ?? json['id'],
      user_id: json["user_id"] ?? '',
      user_name: json["user_name"],
      title: json["title"],
      subtitle: json["subtitle"],
      promoted: json["promoted"],
      language: json["language"],
      about_book: json["about_book"],
      series: json["series"],
      isbn: json["isbn"],
      category: json["category"],
      price: json["price"],
      bookCoverImageURL: json["bookCoverImageURL"],
      bookURL: json["bookURL"],
      audioURL: json["audioUrl"] ?? json["audioURL"],
      filePath: json['filePath'] ?? "",
      filename: json["filename"], //wether file or image
      adult_content: json["adult_content"], //wether file or image
      age_range: json["age_range"], //wether file or image
      own_copyright: json["own_copyright"], //wether file or image
      keywords: json["keywords"], //wether file or image
      reviews: json["reviews"] ?? [], //wether file or image
      contributors: json["contributors"] ?? [],
      createdAt: MyDateFormatter.dateFormatter(
        datetime:
            DateTime.parse(json["createdAt"] ?? '2022-11-02 19:10:31.998691'),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "title": title,
        "subtitle": subtitle,
        "language": language,
        "promoted": promoted,
        "about_book": about_book,
        "series": series,
        "isbn": isbn,
        "category": category,
        "price": price,
        "bookCoverImageURL": bookCoverImageURL,
        "bookURL": bookURL,
        "audioURL": audioURL,
        "filePath": filePath,
        "filename": filename,
        "adult_content": adult_content,
        "age_range": age_range,
        "own_copyright": own_copyright,
        "keywords": keywords,
        "reviews": reviews,
        "contributors": contributors,
        "createdAt": createdAt,
      };
  static String? formatFileName({filename}) {
    return filename.substring(0, filename.indexOf('.'));
  }
}
