import 'package:booky/core/utils/app_constants.dart';
import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String workId;
  final String authorName;
  final String title;
  final int coverId;
  final String firstSentence;
  const Book({
    required this.workId,
    required this.authorName,
    required this.title,
    required this.coverId,
    required this.firstSentence,
  });

  @override
  List<Object?> get props => [
    authorName,
    workId,
    title,
    coverId,
    firstSentence,
  ];
  
  static List<Book> books = [
    const Book(
      workId: 'OL27448W',
      authorName: 'J.R.R. Tolkien',
      title: 'The third book title!',
      coverId: 14627060,
      firstSentence: 'When Mr. Bilbo Baggins Hobbiton.',
    ),
    const Book(
      workId: 'OL27448W',
      authorName: 'J.R.R. Tolkien',
      title: 'The second book title!',
      coverId: 14627060,
      firstSentence: 'When Mr. Bilbo Baggins of Bag End announced that he would shortly be.',
    ),
    const Book(
      workId: 'OL27448W',
      authorName: 'J.R.R. Tolkien',
      title: 'The forth book title!',
      coverId: 14627060,
      firstSentence: 'party of special magnificence, there was much talk and excitement in Hobbiton.',
    ),
    const Book(
      workId: 'OL27448W',
      authorName: 'J.R.R. Tolkien',
      title: 'The first book title!',
      coverId: 14627060,
      firstSentence: 'When Mr. Bilbo Baggins of Bag End announced that he would shortly magnificence, there was much talk and excitement in Hobbiton.',
    ),
  ];
}

extension BookExtension on Book {
  String get cover => '${AppConstants.coverBaseUrl}/$coverId-M.jpg';
}

extension BooksExtension on List<Book> {
  List<Book> filterBooksByAuthorAndTitle(String keyword) => List<Book>.from(where((element) => element.title.contains(keyword) || element.authorName.contains(keyword)));
}