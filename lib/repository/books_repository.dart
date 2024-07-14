import '../data/models/book.dart';
import '../data/resources/local/books_store_provider.dart';
import '../data/resources/remote/books_api_provider.dart';
import 'user_book.dart';

abstract class BooksRepository {
  final BooksApiProvider apiProvider;
  final BooksStoreProvider storeProvider;
  BooksRepository(this.apiProvider, this.storeProvider,);

  /// Remote resource functionalities
  Future<List<Book>> getBooks();
  Future<Book> getBook(String workId);

  /// Local resource functionalities
  List<String> getFavoriteBooks();
  Future addFavoriteBook(String workId);
  Future<List<String>> addFavoriteBooks(List<String> workIds);
  Future removeFavoriteBook(String workId);

  /// runtime user's books created by him/her
  List<UserBook> addUserBook(UserBook book);
  List<UserBook> getUserBooks();
}