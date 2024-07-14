import 'package:booky/presentation/pages/book_details/cubit/book_details_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/remote/app_exceptions.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../data/models/book.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final BooksRepository _booksRepository;
  BookDetailsCubit(this._booksRepository,): super(BookLoading());

  Future<void> fetchBook(String workId, String author) async {
    try {
      emit(BookLoading());

      await Future.delayed(const Duration(seconds: 2,));
      // final book = await _booksRepository.getBook();
      final book = Book(
        workId: '1234',
        authorName: 'Author name',
        title: 'The Lord of Lord now@',
        description: 'Originally published from 1954 through 1956, J.R.R. Tolkien\'s richly complex series ushered in'
            ' a new age of epic adventure storytelling. A philologist and illustrator who took inspiration from his work,'
            ' Tolkien invented the modern heroic quest novel from the ground up, creating not just a world, but a domain,'
            ' not just a lexicon, but a language, that would spawn countless imitators and lead to the inception of the '
            'epic fantasy genre. Today, THE LORD OF THE RINGS is considered "the most influential fantasy novel ever'
            ' written." (THE ENCYCLOPEDIA OF FANTASY)\r\n\r\nDuring his travels across Middle-earth, the hobbit Bilbo '
            'Baggins had found the Ring. But the simple band of gold was far from ordinary; it was in fact the One Ring '
            '- the greatest of the ancient Rings of Power. Sauron, the Dark Lord, had infused it with his own evil magic,'
            ' and when it was lost, he was forced to flee into hiding.\r\n\r\nBut now Sauron\'s exile has ended and his '
            'power is spreading anew, fueled by the knowledge that his treasure has been found. He has gathered all the '
            'Great Rings to him, and will stop at nothing to reclaim the One that will complete his dominion. The only way '
            'to stop him is to cast the Ruling Ring deep into the Fire-Mountain at the heart of the land of Mordor--'
            'Sauron\'s dark realm.\r\n\r\nFate has placed',
          coverId: 14625765,
        firstPublishDate: DateTime.now().subtract(const Duration(days: 10000)),
      );

      emit(BookSuccess(book));
    } on AppException catch(e) {
      logger.e('BookDetailsCubit AppException', error: e.toString(),);
      emit(BookError(e.message));
    } catch(e) {
      logger.e('BookDetailsCubit Exception', error: e,);
      emit(const BookError('something_went_wrong'));
    }
  }
}
