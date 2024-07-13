import 'package:booky/repository/books_repository.dart';
import '../../models/book.dart';

class AppBooksRepository extends BooksRepository {
  AppBooksRepository(super.apiProvider);
  @override
  Future<List<Book>> getBooks() => apiProvider.getBooks();
}