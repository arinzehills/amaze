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
      id: json["_id"],
      user_id: json["user_id"] ?? '',
      user_name: json["user_name"],
      title: json["title"],
      subtitle: json["subtitle"],
      language: json["language"],
      about_book: json["about_book"],
      series: json["series"],
      isbn: json["isbn"],
      category: json["category"],
      price: json["price"],
      bookCoverImageURL: json["bookCoverImageURL"],
      bookURL: json["bookURL"],
      audioURL: json["audioURL"],
      filePath: json['filePath'] ?? "",
      filename: json["filename"], //wether file or image
      adult_content: json["adult_content"], //wether file or image
      age_range: json["age_range"], //wether file or image
      own_copyright: json["own_copyright"], //wether file or image
      keywords: json["keywords"] as List<dynamic>, //wether file or image
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
        "category": category,
        "price": price,
        "bookCoverImageURL": bookCoverImageURL,
        "bookURL": bookURL,
        "filename": filename,
        "filePath": filePath,
        "reviews": reviews,
        // "createdAt": createdAt,
      };
  static String? formatFileName({filename}) {
    return filename.substring(0, filename.indexOf('.'));
  }

  factory BookModel.fromStringJson(stringJson) {
    final myjson = jsonDecode(stringJson);
    // List keywordsJson = json['keywords'] as List<dynamic>;
    // final keywords = keywordsJson;
    // final List keywords = keywordsJson.map((r) => r.toString()).toList();
    print('keywordsJson');
    print(myjson['keywords'].runtimeType);
    print(json.decode(myjson['keywords']));
    print(json.decode(myjson['keywords']).cast<String>());
    return BookModel(
      id: myjson["_id"],
      user_id: myjson["user_id"] ?? '',
      user_name: myjson["user_name"],
      title: myjson["title"],
      subtitle: myjson["subtitle"],
      language: myjson["language"],
      about_book: myjson["about_book"],
      series: myjson["series"],
      isbn: myjson["isbn"],
      category: myjson["category"],
      price: myjson["price"],
      bookCoverImageURL: myjson["bookCoverImageURL"],
      bookURL: myjson["bookURL"],
      audioURL: myjson["audioURL"],
      filePath: myjson['filePath'] ?? "",
      filename: myjson["filename"], //wether file or image
      adult_content: myjson["adult_content"], //wether file or image
      age_range: myjson["age_range"], //wether file or image
      own_copyright: myjson["own_copyright"], //wether file or image
      keywords: myjson['keyword'], //wether file or image
      reviews: myjson["reviews"], //wether file or image
      contributors: myjson["contributors"],
      createdAt: MyDateFormatter.dateFormatter(
        datetime:
            DateTime.parse(myjson["createdAt"] ?? '2022-11-02 19:10:31.998691'),
      ),
    );
  }

  String toStringJson() {
    // final contributorsJson = contributors.map((c) => c).toList();
    final keywordsJson = keywords!.map((k) => k).toList();
    return '{"id": "$id", "user_id": "$user_id", "user_name": "$user_name",'
        '"title": "$title","subtitle": "$subtitle", "language": "$language", "about_book": "$about_book",'
        '"isbn": "$isbn","series": "$series", "category": "$category", "price": "$price",'
        '"bookCoverImageURL": "$bookCoverImageURL","bookURL": "$bookURL", "audioURL": "$audioURL", "contributors": "$contributors",'
        '"filename": "$filename","adult_content": "$adult_content", "age_range": "$age_range", "own_copyright": "$own_copyright",'
        '"filePath": "$filePath","keywords": "$keywordsJson", "reviews": "$reviews", "createdAt": "$createdAt"}';
  }
}
