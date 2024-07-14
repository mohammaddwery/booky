import 'package:booky/core/utils/build_config.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../../core/di/dependencies_container.dart';

List<Book> adaptBooksFromJson(List<dynamic> json) {
  return List<Book>.from(json.map((e) => Book.fromJson(e)).toList());
}

class Book extends Equatable {
  final String workId;
  final String authorName;
  final String title;
  final int? coverId;
  final String? firstSentence;
  final String? subject;
  final String? description;
  final DateTime? firstPublishDate;
  const Book({
    required this.workId,
    required this.authorName,
    required this.title,
    this.coverId,
    this.firstSentence,
    this.subject,
    this.description,
    this.firstPublishDate,
  });

  /// The backend's response is weird so I handled as it is. Sorry!
  factory Book.fromJson(Map<String, dynamic> json) {
    List<String> firstSentences = List<String>.from(json['first_sentence']??[]);
    String? firstSentence = firstSentences.isNotEmpty ? firstSentences.first : null;

    List<String> subjects = List<String>.from(json['subject']??[]);
    String? subject = subjects.isNotEmpty ? subjects.first : null;

    List<String> authorNames = List<String>.from(json['author_name']??[]);
    String authorName = authorNames.isNotEmpty ? authorNames.first : '';

    final workKey = (json['key']??'').toString();
    final workId = workKey.startsWith('/') ? workKey.substring(1) : workKey;

    return Book(
      title: json['title']??'',
      firstSentence: firstSentence,
      subject: subject,
      coverId: json['cover_i'],
      authorName: authorName,
      workId: workId,
    );
  }

  @override
  List<Object?> get props => [
    authorName,
    workId,
    title,
    coverId,
    firstSentence,
    subject,
  ];
}

extension BookExtension on Book {
  String get cover {
    if(coverId == null) return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnFSeIfLviNlTiizgznLZEG-4vmKvvZd7OS0RNseTf3FIzsg-jNR1zKZo7qN8UUwevSnc&usqp=CAU';
    return '${getIt.get<BuildConfig>().coverImageBaseUrl}id/$coverId-M.jpg';
  }

  String get formattedPublishDate => DateFormat('yyyy-MM-dd').format(firstPublishDate??DateTime.now());
}

extension BooksExtension on List<Book> {
  List<Book> filterBooksByAuthorAndTitle(String keyword) => List<Book>.from(where((element) => element.title.toLowerCase().contains(keyword.toLowerCase())
      || element.authorName.toLowerCase().contains(keyword.toLowerCase())));
}