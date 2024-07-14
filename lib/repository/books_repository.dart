import '../data/models/book.dart';
import '../data/resources/remote/books_api_provider.dart';

abstract class BooksRepository {
  final BooksApiProvider apiProvider;
  BooksRepository(this.apiProvider);

  Future<List<Book>> getBooks();
  Future<Book> getBook(String workId);
}