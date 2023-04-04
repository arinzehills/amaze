import 'package:amaze/components/utilities_widgets/mydate_formatter.dart';

class Review {
  // final String role;

  final String? user_id;
  String? user_name;
  final String? user_email;
  final String? comment;
  final int? ratings;
  final String? reviewOn;

  Review({
    this.user_id,
    this.user_name,
    this.user_email,
    this.comment,
    this.ratings,
    this.reviewOn,
  });

  static Review fromJson(Map<String, dynamic> json) => Review(
        user_id: json['user_id'],
        user_name: json['user_name'],
        user_email: json['user_email'],
        comment: json['comment'],
        ratings: json['ratings'],
        reviewOn: MyDateFormatter.dateFormatter(
          datetime:
              DateTime.parse(json["reviewOn"] ?? '2022-11-02 19:10:31.998691'),
        ),
      );
  Map<String, Object?> toJson() => {
        // 'user_id': user_id,
        'user_name': user_name,
        'user_email': user_email,
        // 'email': email,
        // 'profilePicture': profilePicture,
        // 'password': password,
      };
}
