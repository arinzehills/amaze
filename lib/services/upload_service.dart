import 'dart:convert';
import 'dart:io';

import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/Books/upload_book_info.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;

class UploadService {
  Future uploadBook(BookModel bookModel, BookInfo bookInfo) async {
    var user = await AuthService().getuserFromStorage();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$generalUrl/upload/uploadBook'));
    var imagemultipart = await http.MultipartFile.fromPath(
      'image',
      bookInfo.bookcover!.path,
    );
    var filemultipart = await http.MultipartFile.fromPath(
      'file',
      bookInfo.ebook!.path,
    );
    var audiomultipart;
    if (bookInfo.audio != null) {
      print('audio is there');
      print(bookInfo.audio!.path);
      audiomultipart = await http.MultipartFile.fromPath(
        'audio',
        bookInfo.audio!.path,
      );
    }
    print(request.headers['image']);
    print(request.headers['audio']);
    request.headers['x-access-token'] = user.token!;
    request.fields['title'] = bookInfo.title;
    request.fields['subtitle'] = bookInfo.subtitle;
    request.fields['author'] = bookInfo.author;
    request.fields['isbn'] = bookInfo.isbn;
    request.fields['series'] = bookInfo.series;
    for (int i = 0; i < bookInfo.contributors.length; i++) {
      request.fields['contributors[$i]'] = '${bookInfo.contributors[i]}';
    }
    // request.fields['contributors[n]'] = "${bookInfo.contributors[n]}";

    request.fields['language'] = bookModel.language!;
    request.fields['about_book'] = bookModel.about_book!;
    request.fields['category'] = bookModel.category!;
    for (int i = 0; i < bookModel.keywords!.length; i++) {
      request.fields['keywords[$i]'] = '${bookModel.keywords![i]}';
    }
    request.fields['own_copyright'] = bookModel.own_copyright.toString();
    request.fields['adult_content'] = bookModel.adult_content!;
    request.fields['age_range'] = bookModel.age_range!;
    request.fields['price'] = bookModel.price;
    request.fields['filename'] = Path.basename(bookInfo.ebook!.path);
    request.fields['createdAt'] = DateTime.now().toString();
    request.files.add(imagemultipart);
    request.files.add(filemultipart);
    if (bookInfo.audio != null) {
      request.files.add(audiomultipart);
    }
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    // print(response.statusCode);
    return response;
  }

  Future<List<BookModel>> getUserBooks() async {
    var user = await AuthService().getuserFromStorage();
    var data = {
      'token': user.token,
    };
    var response = await AuthService().postData(data, 'upload/getUserBooks');
    //var datar=jsonDecode(response);
    var responseData = json.decode(response.body);
    var postMap = responseData['books'];

    List<BookModel> books = [];
    for (var data in postMap) {
      books.add(BookModel.fromJson(data));
      // postsController.allPost.add(books.fromJson(data));
    }

    // return books;
    return books;
  }

  Future<List<BookModel>> getAllBooks() async {
    var user = await AuthService().getuserFromStorage();
    var data = {
      'token': user.token,
    };
    var response = await AuthService().postData(data, 'upload/getAllBooks');
    //var datar=jsonDecode(response);
    var responseData = json.decode(response.body);
    var postMap = responseData['books'];
    // print('responseData');
    // print(responseData);
    List<BookModel> books = [];
    for (var data in postMap) {
      books.add(BookModel.fromJson(data));
      // postsController.allPost.add(books.fromJson(data));
    }

    // return books;
    return books;
  }

  Future reviewBook(rate, comment, bookID) async {
    var data = {
      'rate': rate,
      'comment': comment,
      'book_id': bookID,
      'reviewOn': DateTime.now().toString()
    };
    var user = await AuthService().getuserFromStorage();

    var response = await AuthService()
        .postData(data, 'upload/reviewBook?token=' + user.token!);
    var body = json.decode(response.body);
    return body;
  }
}
