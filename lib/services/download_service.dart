import 'dart:convert';

import 'package:amaze/models/book_model.dart';
import 'package:amaze/services/auth_service.dart';

class DownloadService {
  Future downloadBook(user_id, book_id) async {
    var user = await AuthService().getuserFromStorage();
    var data = {'token': user.token, 'user_id': user_id, 'book_id': book_id};
    var response = await AuthService().postData(data, 'download/downloadBook');
    var responseData = json.decode(response.body);
    print('responseData');
    print(responseData);
    if (responseData['success'] = true) {
      return {
        "success": true,
        "message": responseData['success'] ?? "success achived"
      };
    } else {
      return {
        "success": false,
        "message": responseData['success'] ?? "success not achived"
      };
    }
  }

  Future<List<BookModel>> getUserDownloads() async {
    var user = await AuthService().getuserFromStorage();
    var data = {
      'token': user.token,
    };
    var response =
        await AuthService().postData(data, 'download/getUserDownloads');
    var responseData = json.decode(response.body);
    var postMap = responseData['books'];
    print(responseData);
    print('postMap');
    print(postMap);
    List<BookModel> books = [];
    for (var data in postMap) {
      books.add(BookModel.fromJson(data));
      // postsController.allPost.add(books.fromJson(data));
    }
    print('books');
    print(books);

    // return books;
    return books;
  }
}
