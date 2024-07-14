import 'package:booky/core/data/remote/api_manager.dart';
import '../../models/book.dart';

abstract class BooksApiProvider {
  final ApiManager _apiManager;
  BooksApiProvider(this._apiManager);

  Future<List<Book>> getBooks();
  Future<Book> getBook(String workId);
}

class AppBooksApiProvider extends BooksApiProvider {
  AppBooksApiProvider(super._apiManager);

  @override
  Future<List<Book>> getBooks() async {
    final response = await _apiManager.get(
      url: _BookApiEndpoints.books,
      queryParameters: {
        'q': 'the lord of the rings', // API needs search keyword
        'limit': 10,
      },
    );
    return adaptBooksFromJson(response['docs']);
  }
  @override
  Future<Book> getBook(workId) async {
    final response = await _apiManager.get(
      url: '${_BookApiEndpoints.works}/$workId.json',
    );
    return Book.fromJson(response);
  }
}

abstract class _BookApiEndpoints {
  static const String books = 'search.json';
  static const String works = 'works';
}